//
//  KSSensorController.h
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
