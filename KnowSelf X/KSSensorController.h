//
//  KSSensorController.h
//  KnowSensor X
//
//  Created by David Ganster on 30/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSFocusSensor.h"


/**
 *  Singleton class that manages all KSSensor objects, server interactions regarding events, and event buffers.
 *  It provides a very limited interface to the outside, allowing other objects to start and stop recording events.
 *  Starting and stopping the recording of events happens asynchronously, and stopping the recording provides
 *  a finished-block for callbacks when all sensors have successfully stopped recording.
 */
@interface KSSensorController : NSObject<KSSensorDelegateProtocol, KSFocusSensorDelegate>

/// Array of sensors currently held by the KSSensorController.
@property(nonatomic, strong, readonly) NSArray *sensors;

/// This flag indicates if the KSSensorDelegate will continuously try to empty its queue
/// or wait for a `ServerReachable` notification before retrying in case an error occurs.
/// Setting this flag to NO will result in higher CPU usage, should the connection to the
/// server be interrupted.
/// Defaults to YES.
@property(nonatomic, assign) BOOL waitForReachability;

/// Accessor to the singleton object.
+ (KSSensorController *)sharedSensorController;

/**
 *  Tells all sensors in `sensors` to register for events.
 *
 *  @return YES iff all sensors returned YES when asked to start recording events.
 */
- (BOOL)startRecordingEvents;

/**
 *  Tells all sensors in `sensors` to unregister for events. 
 *  Since this operation is asynchronous (sensors might need to wait
 *  for events to be processed on another thread), it will return immediately.
 *  To compensate, the given block will be executed once all sensors have finished unsubscribing from events.
 *
 *  @param finished The block to be executed when all sensors are done unsubscribing.
 */
- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished;

@end
