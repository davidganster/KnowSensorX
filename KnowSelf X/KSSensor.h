//
//  KSSensor.h
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


@class KSSensor;
@class KSEvent;

/**
 *  Simple protocol for notifying the sensors delegate when an event has been recorded.
 */
@protocol KSSensorDelegateProtocol <NSObject>


/**
 *  Indicates to the receiver that a sensor has recorded an event.
 *  The `finished` block might be necessary if some part of the application relies on synchronization of events.
 *  @note The implementing class must be prepared to handle cases in which `finished` is nil.
 *
 *  @param sensor   The sensor that generated the event.
 *  @param event    The event that was recorded by the sensor.
 *  @param finished The block to be executed when the delegate finished processing the event.
 */
- (void)sensor:(KSSensor *) sensor didRecordEvent:(KSEvent *)event finished:(void (^)(BOOL success))finished;

@end

/**
 *  Base class for all sensors. Provides a simple interface for starting/stopping the recording of events
 *  and a common initializer.
 */
@interface KSSensor : NSObject {
    @protected
    NSString *_sensorID;
    NSString *_name;
}

/// The delegate that will be notified when events are recorded.
@property(nonatomic, weak) id<KSSensorDelegateProtocol> delegate;

/// Indicates if this sensor is currently active. Inactive sensors will not generate events.
@property(nonatomic, assign, setter = setActive:) BOOL isActive;

/// used for API calls
@property(nonatomic, strong, readonly) NSString *sensorID;

/// used for display names
@property(nonatomic, strong, readonly) NSString *name;

/**
 *  Designated initializer.
 *
 *  @param delegate The delegate that will be notified when the created sensor records events.
 *
 *  @return The newly created sensor.
 */
- (id)initWithDelegate:(id<KSSensorDelegateProtocol>) delegate;

/**
 *  Tells the sensor to start recording events. Calling this method will set `isActive` to `YES`.
 *
 *  @return YES iff the sensor successfully started recording events.
 *  @warning This method is not meant for subclassing. See KSSensor+SubclassingHooks for further information.
 */
- (BOOL)startRecordingEvents;

/**
 *  Tells the sensor to stop recording events. Calling this method will set `isActive` to `NO`.
 *
 *  @param finished The block that will be executed when the sensor has stopped recording events (or has failed to do so).
 *
 *  @warning This method is not meant for subclassing. See KSSensor+SubclassingHooks for further information.
 */
- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished;

@end

/**
 * The methods included in this category are meant to be overridden in subclases, and for internal use only - they should not be called from outside.
 */
@interface KSSensor (SubclassingHooks)

/**
 *  Will be called when the sensor starts recording events. Must be overwritten in a subclass.
 *
 *  @return YES iff registering for events was successful.
 */
- (BOOL)_registerForEvents;

/**
 *  Will be called when the sensor stops recording events. Must be overwritten in a subclass.
 *
 *  @param finished The finished block to call when unsubscribing is completed or has failed.
 *  @note The finished block *must* be called, whether unscubscribing from events was successful or failed.
 */
- (void)_unregisterForEventsFinished:(void (^)(BOOL successful))finished;

@end
