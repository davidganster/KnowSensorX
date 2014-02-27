//
//  KSIdleSensor.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensor.h"

/**
 *  KSSensor subclass that deals with detecting when the user idles and resumes work.
 *  Will record idle events with one second resolution from the given minimumIdleTime 
 *  (implemented efficiently, not by checking every second).
 */
@interface KSIdleSensor : KSSensor

/// The minimum time the user has to be idle before an event is logged in seconds.
@property(atomic, assign) CGFloat minimumIdleTime;

@end
