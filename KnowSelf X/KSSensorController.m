//
//  KSSensorController.m
//  KnowSensor X
//
//  Created by David Ganster on 30/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensorController.h"
#import "KSIdleSensor.h"
#import "KSFocusSensor.h"
#import "KSAPIClient.h"
#import "KSEvent+Addons.h"
#import "KSUserInfo.h"

@interface KSSensorController ()

/// Unused. Might be used in the future to store events until the server becomes reachable, and send them as soon as it becomes reachable again.
@property(nonatomic, strong) NSArray *eventBuffer;

/// Unused. Might be used in the future to set the maximum event buffer size.
@property(nonatomic, assign) NSInteger maxEventBufferSize;

@end

@implementation KSSensorController

+ (KSSensorController *)sharedSensorController
{
    static KSSensorController *_sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [[KSSensorController alloc] init];
    });
    
    return _sharedController;

}

- (id)init
{
    self = [super init];
    if (self) {
        // init sensors:
        KSFocusSensor *focusSensor = [[KSFocusSensor alloc] initWithDelegate:self];
        [focusSensor setFocusDelegate:self];
        KSIdleSensor *idleSensor = [[KSIdleSensor alloc] initWithDelegate:self];
        idleSensor.minimumIdleTime = [[KSUserInfo sharedUserInfo] minimumIdleTime];
        _sensors = @[focusSensor, idleSensor];
    }
    return self;
}

- (BOOL)startRecordingEvents
{
    BOOL success = YES;
    for (KSSensor *sensor in self.sensors) {
        success &= [sensor startRecordingEvents];
    }
    
    LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Starting to record events %@.", success ? @" was successful" : @"FAILED");
    
    return success;
}

- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished
{
    static  NSEnumerator *enumerator = nil;
    if(!enumerator)
        enumerator = [self.sensors objectEnumerator];
    
    __block BOOL success = YES;
    void (^ loop)(BOOL successSoFar) = ^void(BOOL successSoFar) {
        success &= successSoFar;
        KSSensor *sensor = [enumerator nextObject];
        if(sensor) {
            [sensor stopRecordingEventsFinished:^(BOOL successful) {
                [self stopRecordingEventsFinished:finished];
            }];
        } else {
            enumerator = nil;
            if(finished)
                finished(success);
        }
    };
    
    loop(YES);
}

#pragma mark KSFocusSensorDelegate
- (NSString *)focusSensor:(KSFocusSensor *)sensor mappedNameForURL:(NSString *)recordedURL
{
    NSDictionary *dictionary = [[KSUserInfo sharedUserInfo] URLMappings];
    
    // At first, we check if there is an exact match in our table to ensure that
    // specific URLs are matched first.
    NSString *exactMatch = dictionary[recordedURL];
    if(exactMatch)
        return exactMatch;
    
    // If that didn't work, we want full regular expression matching:
    for (NSString *URLToMatch in [dictionary allKeys]) {
        if ([recordedURL rangeOfString:URLToMatch
                               options:NSRegularExpressionSearch].location != NSNotFound) {
//            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Replacing '%@' (matched by '%@') with '%@'.", recordedURL, URLToMatch, dictionary[URLToMatch]);
            return dictionary[URLToMatch];
        }
    }
    return recordedURL;
}

- (BOOL)focusSensor:(KSFocusSensor *)sensor shouldRecordApplication:(NSRunningApplication *)application
{
    BOOL ignoreApplication = NO;
    
    if([kKSFocusSensorBlockedApplicationNames containsObject:application.localizedName]) {
        LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Will ignore application %@", application.localizedName);
        return NO;
    }
    
    if([[[KSUserInfo sharedUserInfo] specialApplications] containsObject:[application.bundleURL absoluteString]]) {
        // specialApplications contains the previous app...
        if([[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]) {
            // ... which means it is on the blacklist. We ignore this app!
            ignoreApplication  = YES;
        }
    } else {
        // specialApplications does not contain the previous app...
        if(![[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]) {
            // ... which means it isn't on the whitelist. We ignore this app!
            ignoreApplication = YES;
        }
    }
    return !ignoreApplication;
}

#pragma mark KSSensorDelegateProtocol

/// This implementation of the KSSensorDelegateProtocol will simply upload the recorded event to the KnowServer using
/// the 'sendEvent:finished:' convenience method of the KSAPIClient class,
/// and then call the provided finished block - regardloess of whether the upload was successful or not.
- (void)sensor:(KSSensor *) sensor didRecordEvent:(KSEvent *)event finished:(void (^)(BOOL success))finished
{
    [[KSAPIClient sharedClient] sendEvent:event finished:^(NSError *error) {
        if(error) {
            LogMessage(kKSLogTagOther, kKSLogLevelError, @"Error when trying to send event! %@", error);
        } else {
            // this event has successfully been sent to the server, so there is no need to keep it around any longer.
            NSManagedObjectContext *context = event.managedObjectContext;
            [context deleteObject:event];
            [context processPendingChanges];
            [context saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
                if(context != [NSManagedObjectContext defaultContext]) {
                    [[NSManagedObjectContext defaultContext] deleteObject:event];
                    [[NSManagedObjectContext defaultContext] save:nil];
                }
            }];
        }
        if(finished)
            finished(!error);
    }];
}

@end
