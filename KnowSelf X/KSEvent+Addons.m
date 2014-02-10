//
//  KSEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 25/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSEvent+Addons.h"

@implementation KSEvent (Addons)

- (BOOL)exportTimestamp:(NSMutableDictionary *)result
{
    NSString *timestampAsString = [self timestampAsString];
    if(!timestampAsString) return NO;

    [result setObject:timestampAsString forKey:@"timestamp"];                                  
    return YES;
}

/// Convenience method to be called from anywhere without having to create an NSDateFormatter object.
- (NSString *)timestampAsString
{
    return [KSUtils dateAsString:self.timestamp];
}


-(NSString *)typeAsString
{
    return [KSEvent stringForType:self.type];
}

/// When you override this method in a subclass, make sure to always append your description to the
/// return value of [super description] (instead of replacing it).
- (NSString *)description
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendFormat:@"Event type = %@, ", [self typeAsString]];
    [desc appendFormat:@"Sensor ID  = %@, ", self.sensorID];
    [desc appendFormat:@"Timestamp  = %@\n", [KSUtils dateAsString:self.timestamp]];
    return desc;
}

@end
