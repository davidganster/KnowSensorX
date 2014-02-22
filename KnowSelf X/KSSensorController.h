//
//  KSSensorController.h
//  KnowSensor X
//
//  Created by David Ganster on 30/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSFocusSensor.h"


/// Singleton class that manages all KSSensor objects, server interactions regarding events, and event buffers.
@interface KSSensorController : NSObject<KSSensorDelegateProtocol, KSFocusSensorDelegate>

/// Array of sensors currently held by the KSSensorController.
@property(nonatomic, strong, readonly) NSArray *sensors;

/// This flag indicates if the KSSensorDelegate will continuously try to empty its queue
/// or wait for a `ServerReachable` notification before retrying in case an error occurs.
/// Defaults to YES.
@property(nonatomic, assign) BOOL waitForReachability;

/// Accessor to the singleton object.
+ (KSSensorController *)sharedSensorController;

- (BOOL)startRecordingEvents;
- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished;

@end
