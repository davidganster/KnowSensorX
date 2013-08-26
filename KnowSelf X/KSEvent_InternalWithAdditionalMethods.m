//
//  KSEvent_InternalWithAdditionalMethods.m
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSEvent_InternalWithAdditionalMethods.h"

@implementation KSEvent_InternalWithAdditionalMethods

- (NSString *)application
{
    NSAssert(NO, @"Subclass of KSEvent must overwrite '- (NSString *) application'.");
    return nil;
}

+ (NSString *)stringForType:(KSEventType)type
{
    switch (type) {
        case KSEventTypeDidGetFocus:
            return kKSEventTypeDidGetFocus;
        case KSEventTypeDidLoseFocus:
            return kKSEventTypeDidLoseFocus;
        case KSEventTypeIdleStart:
            return kKSEventTypeDidStartIdle;
        case KSEventTypeIdleEnd:
            return kKSEventTypeDidEndIdle;
        default:
            return @"unknown type";
            break;
    }
}


@end
