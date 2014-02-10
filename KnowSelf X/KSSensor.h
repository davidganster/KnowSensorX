//
//  KSSensor.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>


@class KSSensor;
@class KSEvent;

/**
 *  Simple protocol for notifying the sensors delegate when an event has been recorded.
 */
@protocol KSSensorDelegateProtocol <NSObject>

/**
 *  Indicates to the receiver that a sensor has recorded an event.
 *
 *  @param sensor The sensor that generated the event.
 *  @param event  The event that was recorded by the sensor.
 */
- (void)sensor:(KSSensor *) sensor didRecordEvent:(KSEvent *)event;

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
 *  @return YES iff the sensor successfully stopped recording events.
 *  @warning This method is not meant for subclassing. See KSSensor+SubclassingHooks for further information.
 */
- (BOOL)stopRecordingEvents;

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
 *  @return YES iff unregistering for events was successful.
 */
- (BOOL)_unregisterForEvents;

@end
