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
@property(nonatomic, strong) NSMutableArray *projectEventObservers;

/// The activity that is currently recording. Will be updated whenever start/stopRecordingActivity: is called.
@property(nonatomic, strong) KSActivity *currentlyRecordingActivity;

/// A list of all projects that are currently available on the server. Will be updated periodically and upon calls to 'createProject:'
@property(nonatomic, strong) NSMutableArray *projectList;

/// A list of all activities that are currently available on the server. Will be updated periodically and upon calls to 'startRecordingActivity:'
@property(nonatomic, strong) NSMutableArray *activityList;

/// Queue for refreshing project/activity lists in the background.
@property(nonatomic, assign) dispatch_queue_t refreshProjectListQueue;

/// Specifies the time interval between two polls for refreshing projects.
@property(nonatomic, assign) CFTimeInterval timeIntervalBetweenPolls;

/// Specifies whether or not to continue the polling loop. Will be YES until `stopUpdatingProjectList` is called.
@property(atomic, assign) BOOL continuePolling;

@end

@implementation KSProjectController

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
        _projectEventObservers = [NSMutableArray array];
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
        [[KSAPIClient sharedClient] loadProjectsWithSuccess:^(NSArray *projects) {
            dispatch_async(self.refreshProjectListQueue, ^{
                NSMutableSet *newProjectsSet = [NSMutableSet setWithArray:projects];
                NSMutableSet *oldProjectsSet = [NSMutableSet setWithArray:self.projectList];
                [newProjectsSet minusSet:oldProjectsSet];
                if([newProjectsSet count] > 0) {
                    // Will also update the observers (asynchronously)
                    self.projectList = [[newProjectsSet allObjects] mutableCopy];
                    LogMessage(kKSLogTagProjectController, kKSLogLevelInfo, @"Project list successfully updated (count = %lu)", (unsigned long)[self.projectList count]);
                }
                if(self.continuePolling)
                    [self updateProjectListWithDelay:self.timeIntervalBetweenPolls];
            });
        } failure:^(NSError *error) {
            LogMessage(kKSLogTagProjectController, kKSLogLevelError, @"Could not load project list! Will try again in %f seconds.", self.timeIntervalBetweenPolls);
            if(self.continuePolling)
                [self updateProjectListWithDelay:self.timeIntervalBetweenPolls];
        }];
    });
}

#pragma mark - Notifying observers
- (void)notifyObserversAboutProjectListChange
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        [observer projectListChanged:self.projectList];
    }
}

- (void)notifyObserversAboutNewActiveActivity
{
    for (id<KSProjectControllerEventObserver> observer in self.projectEventObservers) {
        [observer activeActivityChangedToActivity:self.currentlyRecordingActivity];
    }
}


#pragma mark - Custom Getters/Setters
- (void)setCurrentlyRecordingActivity:(KSActivity *)currentlyRecordingActivity
{
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        self.currentlyRecordingActivity = currentlyRecordingActivity;
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
            [self notifyObserversAboutProjectListChange];
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
                [self notifyObserversAboutProjectListChange];
            });
        }
    });
}

- (void)setProjectList:(NSMutableArray *)projectList
{
    KS_dispatch_async_reentrant(self.refreshProjectListQueue, ^{
        _projectList = projectList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyObserversAboutProjectListChange];
        });
    });
}


#pragma mark -
#pragma mark Public Methods

- (void)startUpdatingProjectListWithTimeInterval:(CFTimeInterval)timeIntervalInSeconds
{
    self.continuePolling = YES;
    self.timeIntervalBetweenPolls = timeIntervalInSeconds;
    [self startUpdatingProjectListWithTimeInterval:0.0];
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
    if([activity.activityID isEqualToString:self.currentlyRecordingActivity.activityID])
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
