//
//  KSScreenshotGrabber.h
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSScreenshotGrabber : NSObject

+ (NSData *)screenshotDataForApplication:(NSRunningApplication *)application scale:(CGFloat)scale;

@end
