//
//  KSIdleEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleEvent+Addons.h"
#import "KSEvent+Addons.h"

@implementation KSIdleEvent (Addons)

// we don't want the timestamp in the data field of idle events.
- (BOOL)exportTimestamp:(NSDictionary *)result
{
    return YES;
}

- (BOOL)exportIdleSinceTimestamp:(NSMutableDictionary *)result
{
    static NSString *key = @"idlesincetimestamp";
    NSString *idleTimeString = [KSUtils dateAsString:self.idleSinceTimestamp];
    if(idleTimeString)
        [result setObject:idleTimeString forKey:key];
    else
        [result setObject:[NSNull null] forKey:key];
    
    return YES;
}

- (BOOL)exportTimeOfRecording:(NSMutableDictionary *)result
{
    static NSString *key = @"timestamp";
    NSString *timeOfRecording = [KSUtils dateAsString:self.timeOfRecording];
    if(timeOfRecording)
        [result setObject:timeOfRecording forKey:key];
    else
        [result setObject:[NSNull null] forKey:key];
    
    return YES;
}

- (NSString *)application
{
    return @"Idle Sensor";
}


- (NSString *)description
{
    NSMutableString *description = [[super description] mutableCopy];
    [description appendFormat:@"idleSinceTimeStamp   = %@, ", self.idleSinceTimestamp];
    [description appendFormat:@"idleSinceSeconds = %@, ", self.idleSinceSeconds];
    return description;
}


@end
