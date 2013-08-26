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

/// Used to get the string representation of the timestamp property.
/// A NSDateFormatter with the format string "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'" will be used.
- (NSString *)timestampAsString
{
    if(!timestampFormatter) {
        timestampFormatter = [[NSDateFormatter alloc] init];
        [timestampFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
    }
    NSString *timestampAsString = [timestampFormatter stringFromDate:self.timestamp];
    return timestampAsString;
}

@end
