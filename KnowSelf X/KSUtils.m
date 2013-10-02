//
//  KSUtils.m
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSUtils.h"
#import "NSAppleEventDescriptor+NDCoercion.h"

// recreating DateFormatters is very slow, so this one is being reused:
static NSDateFormatter *timestampFormatter;

@implementation KSUtils

/// Used to get the string representation of the timestamp property.
/// A NSDateFormatter with the format string "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'" will be used.
+ (NSString *)dateAsString:(NSDate *)date
{
    if(!timestampFormatter) {
        timestampFormatter = [[NSDateFormatter alloc] init];
        [timestampFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
        [timestampFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]]; // TODO: correct?
    }
    NSString *dateAsString = [timestampFormatter stringFromDate:date];
    return dateAsString;
}

+ (NSAppleEventDescriptor *)executeApplescriptWithName:(NSString *)scriptName
                                          functionName:(NSString *)functionName
                                             arguments:(NSArray *)args
                                       errorDictionary:(NSDictionary **)errorDict
{
    NSString *pathAsString = [[NSBundle mainBundle] pathForResource:scriptName
                                                             ofType:@"scpt"];
    
    if(!pathAsString) {
        *errorDict = @{@"info" : [NSString stringWithFormat:@"Script with name %@ not found in main bundle.", scriptName]};
        return nil;
    }
    
    NSAppleEventDescriptor *descriptor;
    
    NSURL *url = [NSURL fileURLWithPath:pathAsString];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:url error:errorDict];
    
    if(*errorDict) {
        return nil;
    }
    
    descriptor = [[NSAppleEventDescriptor alloc] initWithSubroutineName:functionName
                                                         argumentsArray:args];
    
    NSAppleEventDescriptor *result = [script executeAppleEvent:descriptor error:errorDict];
    
    if(*errorDict)
        return nil;
    return result;
}

@end
