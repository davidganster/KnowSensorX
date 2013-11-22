//
//  KSProjectController.m
//  KnowSensor X
//
//  Created by David Ganster on 17/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSProjectController.h"
#import "KSAPIClient.h"
#import "KSProject+Addons.h"
#import "KSActivity+Addons.h"

@interface KSProjectController ()

/// Contains all observers (they must the KSProjectControllerEventObserver protocol).
/// Every observer can only be in the list once, hence we use an NSMutableSet.
@property(nonatomic, strong) NSMutableSet *projectEventObservers;

/// The activity that is currently recording. Will be updated whenever start/stopRecordingActivity: is called.
@property(nonatomic, strong) KSActivity *currentlyRecordingActivity;

/// A list of all projects that are currently available on the server. Will be updated periodically and upon calls to 'createProject:'
@property(nonatomic, strong) NSMutableArray *projectList;

/// A list of all activities that are currently available on the server. Will be updated periodically and upon calls to 'startRecordingActivity:'
@property(nonatomic, strong) NSMutableArray *activityList;

/// Queue for refreshing project/activity lists in the background.
@property(nonatomic, assign) dispatch_queue_t refreshProjectListQueue;

/// Specifies whether or not to continue the polling loop. Will be YES until `stopUpdatingProjectList` is called.
@property(atomic, assign) BOOL continuePolling;

@end

@implementation KSProjectController

// MUST manually synthesize the ivar, because both getter and setter have been overwritten.
@synthesize timeIntervalBetweenPolls = _timeIntervalBetweenPolls;

#pragma mark - Private Methods
+ (KSProjectController *)sharedProjectController
{
    static dispatch_once_t onceToken;
    static KSProjectController *controller = nil;
    dispatch_once(&onceToken, ^{
        controller = [[KSProjectController alloc] init];
    });
    return controller;
}

- (KSProjectController *)init
{
    self = [super init];
    if(self) {
        _projectEventObservers = [NSMutableSet set];
        _projectList = [NSMutableArray array];
        _activityList = [NSMutableArray array];
        _currentlyRecordingActivity = nil;
        _refreshProjectListQueue = dispatch_queue_create("com.kc.KnowSensorX.ProjectListQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - Updating the project list:
- (void)updateProjectListWithDelay:(double)delayInSeconds
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, _refreshProjectListQueue, ^(void) {
        // Refresh project list
        [[KSAPIClient sharedClient] loadProjectsWithSuccess:^(NSArray *projects) {
            [[KSAPIClient sharedClient] loadAllActivities:^(NSArray *activities) {
                // Both projects and activities are now loaded.
                // If one of the calls returns an error, the list is not updated.
                dispatch_async(self.refreshProjectListQueue, ^{
                    if([projects isEqualToArray:self.projectList] && [activities isEqualToArray:self.activityList]) {
                        [self finishPollSuccesful:YES]; // nothing has changed.
                    } else {
                        // something has changed, need to update lists
                        for (KSProject *project in projects) {
                            NSOrderedSet *activitiesForProject = [NSOrderedSet orderedSetWithArray:[activities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.projectName like %@", project.name]]];
                            [project setActivities:activitiesForProject];
                        }
                        // this will also asynchronously update the observers:
                        self.projectList = [projects mutableCopy];
                        self.activityList = [activities mutableCopy];
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
            // The project this activity belongs to should definitely be in our list.
            // If it isn't - tough luck, it will be next time.
            for (KSProject *project in self.projectList) {
                if([currentActivity.projectName isEqualToString:project.name]) {
                    currentActivity.project = project;
                }
            }
            self.currentlyRecordingActivity = currentActivity; // Will also update the observers (asynchronously).
        } failure:^(NSError *error) {
            LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not load currently active activity! Will try again in %f seconds.", self.timeIntervalBetweenPolls);
        }];
        
    });
}

- (void)finishPollSuccesful:(BOOL)success
{
    if(success) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Project and activity list successfully updated (project count = %lu, activity count = %lu)", (unsigned long)[self.projectList count], [self.activityList count]);
    } else {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not load project list! Will try again in %f seconds.", self.timeIntervalBetweenPolls);
    }
    if(self.continuePolling)
        [self updateProjectListWithDelay:self.timeIntervalBetweenPolls];
}

#pragma mark - Notifying observers
- (void)notifyObserversAboutProjectListChangeWithAddedObjects:(NSArray *)addedObjects deletedObjects:(NSArray *)deletedObjects
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        if([observer respondsToSelector:@selector(projectController:projectListChangedWithAddedProjects:deletedProjects:)])
            [observer projectController:self projectListChangedWithAddedProjects:addedObjects deletedProjects:deletedObjects];
    }
}

- (void)notifyObserversAboutNewActiveActivity
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        if([observer respondsToSelector:@selector(projectController:activeActivityChangedToActivity:)])
            [observer projectController:self activeActivityChangedToActivity:self.currentlyRecordingActivity];
    }
}

#pragma mark - Custom Getters/Setters

- (void)setTimeIntervalBetweenPolls:(CFTimeInterval)timeIntervalBetweenPolls
{
    // do this AFTER the current queue finishes.
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        _timeIntervalBetweenPolls = timeIntervalBetweenPolls;
    });
}

- (CFTimeInterval)timeIntervalBetweenPolls
{
    __block CFTimeInterval timeInterval;
    KS_dispatch_sync_reentrant(self.refreshProjectListQueue, ^{
        timeInterval = _timeIntervalBetweenPolls;
    });
    return timeInterval;
}

- (void)setCurrentlyRecordingActivity:(KSActivity *)currentlyRecordingActivity
{
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        _currentlyRecordingActivity = currentlyRecordingActivity;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyObserversAboutNewActiveActivity];
        });
    });
}

- (NSArray *)currentProjectList
{
    __block NSArray *projects;
    KS_dispatch_sync_reentrant(self.refreshProjectListQueue, ^{
        projects = self.projectList;
    });
    return projects;
}

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
        
        if(newProjects.count == 0 && oldProjects.count == 0)
            return; // nothing added, nothing removed - nothing to do.
        
        _projectList = projectList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyObserversAboutProjectListChangeWithAddedObjects:[newProjects array]
                                                         deletedObjects:[oldProjects array]];
        });
    });
}

#pragma mark -
#pragma mark Public Methods

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
    [[KSAPIClient sharedClient] createProject:project success:^(NSString *newProjectID) {
        project.projectID = newProjectID;
        [self addProjectListObject:project]; // Will dispatch to correct queue and notify observers.
        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully created project with new ID: %@", newProjectID);
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to create a new project: %@", error);
    }];
}

- (void)startRecordingActivity:(KSActivity *)activity
{
    if(activity == nil || [activity.activityID isEqualToString:self.currentlyRecordingActivity.activityID])
        return;
    
    if(self.currentlyRecordingActivity != nil) {
        [self stopRecordingActivity:self.currentlyRecordingActivity];
    }
    
    [[KSAPIClient sharedClient] startRecordingActivity:activity success:^(NSString *newActivityID) {
        activity.activityID = newActivityID;
        self.currentlyRecordingActivity = activity;
        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully started to record activity with ID: %@", newActivityID);
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to record acivity (name = %@): %@", activity.name, error);
    }];
}


- (void)stopRecordingActivity:(KSActivity *)activity
{
    if(![self.currentlyRecordingActivity.activityID isEqualToString:activity.activityID])
        return;
    [[KSAPIClient sharedClient] stopRecordingActivity:activity success:^{
        self.currentlyRecordingActivity = nil;
        LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Successfully stopped recording activity (name = %@)", activity.name);
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"ERROR when trying to stop recording activity (name = %@): %@", activity.name, error);
    }];
}


@end