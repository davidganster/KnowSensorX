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
static NSDateFormatter *activityTimestampFormatter;

@implementation KSUtils

+ (NSString *)dateAsString:(NSDate *)date
{
    if(!timestampFormatter) {
        timestampFormatter = [[NSDateFormatter alloc] init];
        [timestampFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
        [timestampFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    NSString *dateAsString = [timestampFormatter stringFromDate:date];
    return dateAsString;
}

+ (NSDate *)dateFromString:(NSString *)string
{
    if(!activityTimestampFormatter) {
        activityTimestampFormatter = [[NSDateFormatter alloc] init];
        [activityTimestampFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [activityTimestampFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    NSDate *dateFromString = [activityTimestampFormatter dateFromString:string];
    if(!dateFromString) {
        dateFromString = [timestampFormatter dateFromString:string];
    }
    return dateFromString;
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

+ (BOOL)accessibilityPopupAvailable
{
    NSDictionary *systemVersionDictionary =
    [NSDictionary dictionaryWithContentsOfFile:
     @"/System/Library/CoreServices/SystemVersion.plist"];
    
    NSString *systemVersion =
    [systemVersionDictionary objectForKey:@"ProductVersion"];
    LogMessage(@"DEBUG ONLY", 0, @"OS VERSION = %@", systemVersion);
    return !([systemVersion floatValue] <= 10.8f); // available in OS X Mavericks (and probably above)
}

+ (BOOL)isFirstStart
{
    BOOL hasBeenStartedBefore = [[NSUserDefaults standardUserDefaults] boolForKey:kKSIsFirstStartKey];
    if(!hasBeenStartedBefore) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kKSIsFirstStartKey];
    }
    return !hasBeenStartedBefore;
}

+ (CGFloat)scaleForScreenshotQuality:(KSScreenshotQuality)quality
{
    // best effort: can only check which screen has the keyboard focus (= mainScreen),
    // not which window has the focus.
    CGFloat screenScale = [[NSScreen mainScreen] backingScaleFactor];
    switch (quality) {
        case KSScreenshotQualityOriginal:
            return 1.0f/screenScale;
        case KSScreenshotQualityMedium:
            return 0.5f/screenScale;
        case KSScreenshotQualitySmall:
            return 0.25/screenScale;
        default:
            // don't know this quality option, will return default:
            return 0.5f/screenScale;
            break;
    }
}

@end
