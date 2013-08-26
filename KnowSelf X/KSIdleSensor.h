//
//  KSIdleSensor.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensor.h"

@interface KSIdleSensor : KSSensor

/// The minimum time the user has to be idle before an event is logged in seconds.
/// Defaults to 300 (5 minutes).
@property(nonatomic, assign) CGFloat minimumIdleTime;

@end
