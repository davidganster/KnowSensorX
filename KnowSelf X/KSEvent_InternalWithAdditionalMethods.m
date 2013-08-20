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

@end
