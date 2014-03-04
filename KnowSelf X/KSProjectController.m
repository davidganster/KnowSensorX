//
//  KSProjectController.m
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "KSProjectController.h"
#import "KSAPIClient.h"
#import "KSProject.h"
#import "KSActivity.h"

@interface KSProjectController ()

/// Contains all observers (they must the KSProjectControllerEventObserver protocol).
/// Every observer can only be in the list once, hence we use an NSMutableSet.
@property(nonatomic, strong) NSMutableSet *projectEventObservers;

/// A list of all projects that are currently available on the server. Will be updated periodically and upon calls to 'createProject:'
@property(nonatomic, strong) NSMutableArray *projectList;

/// A list of all activities that are currently available on the server. Will be updated periodically and upon calls to 'startRecordingActivity:'
@property(nonatomic, strong) NSMutableArray *activityList;

/// Queue for refreshing project/activity lists in the background.
@property(nonatomic, assign) dispatch_queue_t refreshProjectListQueue;

/// Specifies whether or not to continue the polling loop. Will be YES until `stopUpdatingProjectList` is called.
@property(atomic, assign) BOOL continuePolling;

/// Indicates if a new activity is just about to start recording.
/// In this case, we will ignore the return value of `loadActiveActivity:` in
/// `updateProjectListWithDelay:` (it might return the 'old' active activity,
/// not the one that we just started to record).
@property(nonatomic, assign) BOOL isStartingNewRecording;

@end

@implementation KSProjectController

// MUST manually synthesize the ivar, because both getter and setter have been overwritten.
@synthesize timeIntervalBetweenPolls = _timeIntervalBetweenPolls;

#pragma mark - Private Methods
/// @name Private Methods

/**
 *  Designated initializer. 
 *  @warning Do not attempt to create a KSProjectController on your own. Use the singleton-accessor (`sharedProjectController`) instead.
 *
 *  @return A new, fully initialized instance of KSProjectController.
 */
- (KSProjectController *)init
{
    self = [super init];
    if(self) {
        _projectEventObservers = [NSMutableSet set];
        _projectList = [NSMutableArray array];
        _activityList = [NSMutableArray array];
        _currentlyRecordingActivity = nil;
        _refreshProjectListQueue = dispatch_queue_create("com.kc.KnowSensorX.ProjectListQueue", DISPATCH_QUEUE_SERIAL);
        _isStartingNewRecording = NO;
    }
    return self;
}

#pragma mark - Updating the project list
/// @name Managing the project/activity list

/**
 *  Internal method.
 *  Sends a request for all projects and all activities to the server and waits for 
 *  a positive reply from the server. Upon completion of both calls, the project list and activity list
 *  will be updated, notifying all observers in the process.
 *  Regardless of the API calls worked, the KSProjectController will continue calling this method after
 *  `timeIntervalBetweenPolls` has passed.
 *  To stop polling, call `stopUpdatingProjectList` - this will set `continuePolling` to NO.
 *
 *  @param delayInSeconds Amount of time in seconds to wait before starting the new poll.
 */
- (void)updateProjectListWithDelay:(double)delayInSeconds
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, _refreshProjectListQueue, ^(void) {
        // Refresh project list
        [[KSAPIClient sharedClient] loadProjectsWithSuccess:^(NSArray *projects) {
            [[KSAPIClient sharedClient] loadAllActivities:^(NSArray *activities) {
                
                // The server might send every activity multiple times (for each time this activity was recorded)
                // - but we only care about the name and project.
                // O(n^2) is not pretty, but necessary without additional data.
                NSMutableArray *activitiesWithoutDuplicates = [NSMutableArray new];
                for (KSActivity *duplicateCandidate in activities) {
                    BOOL isAlreadyContained = NO;
                    for (KSActivity *activity in activitiesWithoutDuplicates) {
                        if(duplicateCandidate.name == activity.name &&
                           duplicateCandidate.projectName == activity.projectName) {
                            isAlreadyContained = YES;
                            break;
                        }
                    }
                    if(!isAlreadyContained) {
                        [activitiesWithoutDuplicates addObject:duplicateCandidate];
                    }
                }

                // Both projects and activities are now loaded.
                // If one of the calls returns an error, the list is not updated.
                dispatch_async(self.refreshProjectListQueue, ^{
                    if([projects isEqualToArray:self.projectList] &&
                       [activitiesWithoutDuplicates isEqualToArray:self.activityList]) {
                        [self finishPollSuccesful:YES]; // nothing has changed.
                    } else {
                        
                        // something has changed, need to update lists
                        for (KSProject *project in projects) {
                            NSOrderedSet *activitiesForProject = [NSOrderedSet orderedSetWithArray:[activitiesWithoutDuplicates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.projectName like %@", project.name]]];
                            [project setActivities:activitiesForProject];
                        }
                        // this will also asynchronously update the observers:
                        self.projectList = [projects mutableCopy];
                        self.activityList = [activitiesWithoutDuplicates mutableCopy];
                        [self finishPollSuccesful:YES];
                    }
                });
            } failure:^(NSError *error) {
                [self finishPollSuccesful:NO];
            }];
        } failure:^(NSError *error) {
            [self finishPollSuccesful:NO];
        }];
        
            // Refresh active activity
            [[KSAPIClient sharedClient] loadActiveActivity:^(KSActivity *currentActivity) {
                dispatch_async(_refreshProjectListQueue, ^{
                    if(!self.isStartingNewRecording) {
                        // The project this activity belongs to should definitely be in our list.
                        // If it isn't - tough luck, it will be next time.
                        for (KSProject *project in self.projectList) {
                            if([currentActivity.projectName isEqualToString:project.name]) {
                                currentActivity.project = project;
                                break;
                            }
                        }
                        self.currentlyRecordingActivity = currentActivity; // Will also update the observers (asynchronously).
                    }
                });
            } failure:^(NSError *error) {
                LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not load currently active activity! Will try again in %f seconds.", self.timeIntervalBetweenPolls);
            }];
    });
}

/**
 *  Internal method. Called when `updateProjectListWithDelay:` is done with one poll - 
 *  whether it was successful or not.
 *  The `success` parameter is currently only used for debug purposes (i.e. for logging).
 *
 *  @param success Indicates whether or not the poll was successful. Only used for logging at the moment.
 */
- (void)finishPollSuccesful:(BOOL)success
{
    if(success) {
//        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Project and activity list successfully updated (project count = %lu, activity count = %lu)", [self.projectList count], [self.activityList count]);
    } else {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not load project list! Will try again in %f seconds.", self.timeIntervalBetweenPolls);
    }
    if(self.continuePolling)
        [self updateProjectListWithDelay:self.timeIntervalBetweenPolls];
}

#pragma mark - Notifying observers
/// @name Notifying observers

/**
 *  Internal method. 
 *  This method will loop through all observers of project events and notfify them about changes
 *  to the project list.
 *
 *  @param addedObjects   The objects that have been added to the project list.
 *  @param deletedObjects The object that have been deleted from the project list.
 */
- (void)notifyObserversAboutProjectListChangeWithAddedObjects:(NSArray *)addedObjects
                                               deletedObjects:(NSArray *)deletedObjects
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        if([observer respondsToSelector:@selector(projectController:projectListChangedWithAddedProjects:deletedProjects:)])
            [observer projectController:self projectListChangedWithAddedProjects:addedObjects deletedProjects:deletedObjects];
    }
}

/**
 *  Internal method.
 *  This method will loop through all observers of project events and notfify them about the change 
 *  of the active activity.
 */
- (void)notifyObserversAboutNewActiveActivity
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        if([observer respondsToSelector:@selector(projectController:activeActivityChangedToActivity:)])
            [observer projectController:self activeActivityChangedToActivity:self.currentlyRecordingActivity];
    }
}

#pragma mark - Custom Getters/Setters
/// Custom getters/setters

/**
 *  Sets the new time interval between two polls for project/activity updates.
 *  @note This method returns immediately, dispatching to the internal queue for refreshing projects, meaning you cannot assume the property to be set correctly upon return.
 *
 *  @param timeIntervalBetweenPolls The new time interval between two polls. Will be used after the current poll is finished.
 */
- (void)setTimeIntervalBetweenPolls:(CFTimeInterval)timeIntervalBetweenPolls
{
    // do this AFTER the current queue finishes.
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        _timeIntervalBetweenPolls = timeIntervalBetweenPolls;
    });
}

/**
 *  Getter for the current time interval between polls.
 *  @note This method synchronously dipatches to the internal queue for refreshing projects, so it might take some time to return (potentially 2 round trips to the server)!
 *
 *  @return The time interval between two polls.
 */
- (CFTimeInterval)timeIntervalBetweenPolls
{
    __block CFTimeInterval timeInterval;
    KS_dispatch_sync_reentrant(self.refreshProjectListQueue, ^{
        timeInterval = _timeIntervalBetweenPolls;
    });
    return timeInterval;
}

/**
 *  Internal method. 
 *  Sets the currently active activity. Also notifies observers about the change.
 *  @warning Attempting to modify the active activity with bogus data from outside might corrupt the state of the KSProjectController.
 *
 *  @param currentlyRecordingActivity The new currently recording activity. Must match the value returned from the server.
 */
- (void)setCurrentlyRecordingActivity:(KSActivity *)currentlyRecordingActivity
{
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        if(_currentlyRecordingActivity == currentlyRecordingActivity) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            _currentlyRecordingActivity = currentlyRecordingActivity;
            [self notifyObserversAboutNewActiveActivity];
        });
    });
}

/**
 *  Internal method.
 *  Adds an object to the project list, dispatching asynchronously to the internal project list queue.
 *  Observers will be notified about the change.
 *
 *  @param project The project to be added.
 */
- (void)addProjectListObject:(KSProject *)project
{
    // All updates on the projectList must happen on the refreshProjectListQueue.
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        [self.projectList addObject:project];
        // Callbacks for observers will happen on the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyObserversAboutProjectListChangeWithAddedObjects:@[project]
                                                         deletedObjects:nil];
        });
    });
}

/**
 *  Internal method.
 *  Removes the given project from the project list, dispatching asynchronously to the internal project list queue.
 *  Observers will be notified about the change.
 *
 *  @param project The project to be removed from the project list.
 */
- (void)removeProjectListObject:(KSProject *)project
{
    // All updates on the projectList must happen on the refreshProjectListQueue.
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        if([self.projectList containsObject:project]) {
            [self.projectList removeObject:project];
            // Callbacks for observers will happen on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self notifyObserversAboutProjectListChangeWithAddedObjects:nil
                                                             deletedObjects:@[project]];
            });
        }
    });
}

/**
 *  Sets the project list to the given project list, analyzes changes to the project list and
 *  notifies observers about the changes.
 *
 *  @param projectList The new project list.
 */
- (void)setProjectList:(NSMutableArray *)projectList
{
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        if(self.projectList == projectList)
            return;
        // important: preserve order of objects.
        NSMutableOrderedSet *oldProjects = [NSMutableOrderedSet orderedSetWithArray:_projectList];
        NSMutableOrderedSet *newProjects = [NSMutableOrderedSet orderedSetWithArray:projectList];
        
        [newProjects minusOrderedSet:oldProjects]; // all new (added) objects will remain
        [oldProjects minusOrderedSet:[NSOrderedSet orderedSetWithArray:projectList]]; // all old (deleted) objects will remain
        
        _projectList = projectList;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // even if there are 0 'new' or 'deleted' projects - their activities might have changed!
            [self notifyObserversAboutProjectListChangeWithAddedObjects:[newProjects array]
                                                         deletedObjects:[oldProjects array]];
        });
    });
}

#pragma mark -
#pragma mark Public Methods
/// @name Public methods

+ (KSProjectController *)sharedProjectController
{
    static dispatch_once_t onceToken;
    static KSProjectController *controller = nil;
    dispatch_once(&onceToken, ^{
        controller = [[KSProjectController alloc] init];
    });
    return controller;
}

- (NSArray *)currentProjectList
{
    __block NSArray *projects;
    KS_dispatch_sync_reentrant(self.refreshProjectListQueue, ^{
        projects = self.projectList;
    });
    return projects;
}

- (void)startUpdatingProjectListWithTimeBetweenPolls:(CFTimeInterval)timeIntervalInSeconds
{
    self.continuePolling = YES;
    self.timeIntervalBetweenPolls = timeIntervalInSeconds;
    [self updateProjectListWithDelay:0.0];
}

- (void)stopUpdatingProjectList
{
    self.continuePolling = NO;
}

- (void)addObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer
{
    dispatch_async(self.refreshProjectListQueue, ^{
        if(![self.projectEventObservers containsObject:observer])
            [self.projectEventObservers addObject:observer];
    });
}

- (void)removeObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer
{
    dispatch_async(self.refreshProjectListQueue, ^{
        if(![self.projectEventObservers containsObject:observer])
            [self.projectEventObservers removeObject:observer];
    });
}

- (void)createProject:(KSProject *)project
{
    [self createProject:project success:nil failure:nil];
}

- (void)createProject:(KSProject *)project success:(void (^)())success failure:(void (^)(NSError *error))failure
{
    [[KSAPIClient sharedClient] createProject:project success:^(NSString *newProjectID) {
        project.projectID = newProjectID;
        [self addProjectListObject:project]; // Will dispatch to correct queue and notify observers.
//        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully created project with new ID: %@", newProjectID);
        if(success)
            success();
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to create a new project: %@", error);
        if(failure)
            failure(error);
    }];
}

- (void)startRecordingActivity:(KSActivity *)activity
{
    if(activity == nil || [activity.activityID isEqualToString:self.currentlyRecordingActivity.activityID])
        return;
    
    dispatch_async(_refreshProjectListQueue, ^{
        self.isStartingNewRecording = YES;
        void (^startRecording)() = ^void() {
            [[KSAPIClient sharedClient] startRecordingActivity:activity success:^(NSString *newActivityID) {
                dispatch_async(_refreshProjectListQueue, ^{
                    activity.activityID = newActivityID;
                    self.currentlyRecordingActivity = activity;
                    
//                    LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully started to record activity with ID: %@", newActivityID);
                    self.isStartingNewRecording = NO;
                });
            } failure:^(NSError *error) {
                LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to record acivity (name = %@): %@", activity.name, error);
            }];
        };
        
        if(self.currentlyRecordingActivity != nil) {
            [self stopRecordingCurrentActivitySuccess:^{
                startRecording();
            } failure:^(NSError *error) {
                // hmmm... what now?
                LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not stop recording active activity! Error: (%@)", error);
            }];
        } else {
            startRecording();
        }
    });
    
}


- (void)stopRecordingCurrentActivitySuccess:(void (^)())success failure:(void (^)(NSError *error))failure
{
    
    [[KSAPIClient sharedClient] stopRecordingActivity:self.currentlyRecordingActivity success:^{
//        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully stopped recording activity (name = %@)", self.currentlyRecordingActivity.name);
        self.currentlyRecordingActivity = nil;

        if(success)
            success();
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to stop recording activity (name = %@): %@", self.currentlyRecordingActivity.name, error);
//        self.currentlyRecordingActivity = nil;
        
        if(failure)
            failure(error);
    }];
}


@end
