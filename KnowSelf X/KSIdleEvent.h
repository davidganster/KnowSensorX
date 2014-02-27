//
//  KSIdleEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 18/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"

/**
 *  Describes an idle event to be sent to the server.
 *  Mirrors the data model on the KnowServer.
 */
@interface KSIdleEvent : KSEvent

/// Shows how long the user is already idle at the time of sending the event.
/// For an KSEventTypeIdleStart event, this is the currently set idle time, for the KSEventTypeIdleEnd,
/// this will be timeOfRecording - idleSinceTimestamp.
@property (nonatomic, retain) NSNumber * idleSinceSeconds;
/// The timestamp when the user entered the idle-state.
@property (nonatomic, retain) NSDate * idleSinceTimestamp;
/// The timestamp when the event is recorded. Same as timestamp in the KSEvent, but required by the server.
@property (nonatomic, retain) NSDate * timeOfRecording;

@end
