//
//  KSIdleEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleEvent+Addons.h"

@implementation KSIdleEvent (Addons)


// we don't want the timestamp in the data field of idle events.
- (BOOL) exportTimestamp:(NSDictionary *)result
{
    return YES;
}

- (NSString *)application
{
    return @"Idle Sensor";
}

@end
