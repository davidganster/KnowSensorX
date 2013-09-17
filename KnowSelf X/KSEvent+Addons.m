//
//  KSEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 25/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSEvent+Addons.h"

@implementation KSEvent (Addons)

// recreating DateFormatters is very slow, so this one is being reused:
static NSDateFormatter *timestampFormatter;

- (BOOL)exportTimestamp:(NSMutableDictionary *)result
{
    NSString *timestampAsString = [self timestampAsString];
    if(timestampAsString)
        [result setObject:timestampAsString forKey:@"timestamp"];
                                      
    return YES;
}

/// Convenience method to be called from anywhere without having to create an NSDateFormatter object.
- (NSString *)timestampAsString
{
    return [self dateAsString:self.timestamp];
}

/// Used to get the string representation of the timestamp property.
/// A NSDateFormatter with the format string "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'" will be used.
- (NSString *)dateAsString:(NSDate *)date
{
    if(!timestampFormatter) {
        timestampFormatter = [[NSDateFormatter alloc] init];
        [timestampFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
    }
    NSString *dateAsString = [timestampFormatter stringFromDate:date];
    return dateAsString;
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
    [desc appendFormat:@"Sensor ID = %@, ", self.sensorID];
    [desc appendFormat:@"Timestamp: %@\n", self.timestamp];
    return desc;
}

@end
