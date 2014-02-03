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
        KSIdleSensor *idleSensor = [[KSIdleSensor alloc] initWithDelegate:self];
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

- (BOOL)stopRecordingEvents
{
    BOOL success = YES;
    for (KSSensor *sensor in self.sensors) {
        success &= [sensor stopRecordingEvents];
    }
    
    LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Stopping to record events %@.", success ? @" was successful" : @"FAILED");

    return success;
}


#pragma mark KSSensorDelegateProtocol
/// This implementation of the KSSensorDelegateProtocol will simply upload the recorded event to the KnowServer using
/// the 'sendEvent:finished:' convenience method of the KSAPIClient class.
- (void)sensor:(KSSensor *)sensor didRecordEvent:(KSEvent *)event
{
    [[KSAPIClient sharedClient] sendEvent:event finished:^(NSError *error) {
        if(error) {
            LogMessage(kKSLogTagOther, kKSLogLevelError, @"Error when trying to send event! %@", error);
        } else {
//            LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Sent data successfully!");
        }
    }];
}

@end
