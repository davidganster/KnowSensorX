//
//  KSFocusEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusEvent+Addons.h"

@implementation KSFocusEvent (Addons)

// TODO: actually export the screenshot in one of those methods.
- (BOOL)exportScreenshotPath:(NSDictionary *)result
{
    NSLog(@"correct method is 'exportScreenshotPath' !");
    return YES;
}

- (BOOL)exportScreenshot:(NSDictionary *)result
{
    NSLog(@"correct method is 'exportScreenshot' !");
    return YES;
}

- (NSString *)application
{
    return self.processName;
}

@end
