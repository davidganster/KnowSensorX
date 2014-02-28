//
//  KSEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 26/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"

/**
 *  Base class for all events to be sent to the server.
 *  If you want to send events to the server, you must extend this class.
 *  Mirrors the data model on the KnowServer.
 *  All properties added in the subclasses (and exported in dictRepresentation)
 *  will be base64 encoded.
 */
@interface KSEvent : NSObject<KSExportable>

/// The ID of the sensor that recorded the event.
@property (nonatomic, retain) NSString * sensorID;
/// Identifies the time of recording of this event.
@property (nonatomic, retain) NSDate * timestamp;
/// The type of the event.
@property (nonatomic) KSEventType type;


/**
 *  Helper method for getting the type as a string - needed for export to JSON and logging.
 *
 *  @return The type of the receiver in a string representation.
 */
- (NSString *)typeAsString;

/**
 *  The application that has been recorded - not a member because some sensors might 
 *  not actually record specific applications. The subclass must return a non-nil value here.
 *
 *  @return The application that recorded the event.
 */
- (NSString *)application;

/**
 *  Returns `timestamp` as a string, using the KSUtils convenience method `stringFromDate:`.
 *
 *  @return The `timestamp` of the receiver, formatted as an NSString.
 */
- (NSString *)timestampAsString;

/**
 *  Converts the given event-type into a string. Needed for export to JSON and logging.
 *
 *  @param type The type to be converted.
 *
 *  @return The string representation of the given type.
 */
+ (NSString *)stringForType:(KSEventType)type;

@end
