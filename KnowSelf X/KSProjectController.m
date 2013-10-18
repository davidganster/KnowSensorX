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
@property(nonatomic, strong) KSActivity *currentlyRecordingActivity;
@end

@implementation KSProjectController

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
        _currentlyRecordingActivity = nil;
    }
    return self;
}

- (void)addObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer
{
    if(![self.projectEventObservers containsObject:observer])
       [self.projectEventObservers addObject:observer];
}

- (void)removeObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer
{
    if([self.projectEventObservers containsObject:observer])
       [self.projectEventObservers removeObject:observer];
}

- (void)createProject:(KSProject *)project
{
    [[KSAPIClient sharedClient] createProject:project success:^(NSString *newProjectID) {
        project.projectID = newProjectID;
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
