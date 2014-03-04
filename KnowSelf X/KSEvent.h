//
//  KSEvent.h
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
