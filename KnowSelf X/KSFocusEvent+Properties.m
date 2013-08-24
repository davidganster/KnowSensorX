//
//  KSFocusEvent+Properties.m
//  KnowSensor X
//
//  Created by David Ganster on 24/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusEvent+Properties.h"
#import <objc/runtime.h>

static char const * const screenShotKey = "screenShot";

@implementation KSFocusEvent (Properties)

@dynamic screenshot;

- (NSImage *)screenshot
{
    return objc_getAssociatedObject(self, screenShotKey);
}

-(void)setScreenshot:(NSImage *)screenshot
{
    objc_setAssociatedObject(self, screenShotKey, screenshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
