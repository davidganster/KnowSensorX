//
//  KSScreenshotGrabber.h
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSScreenshotData;

/**
 *  Helper class to easily retrieve screenshots in the correct format for the server.
 *  Only has a single public method that returns an object of type KSScreenshotData, 
 *  but can be extended very easily to return `NSImage` objects (an internal method that does this already exists).
 */
@interface KSScreenshotGrabber : NSObject

/**
 *  Tries to detect the frontmost window of the given application and retrieves a screenshot
 *  for it, embedding it inside a KSScreenshotData object. The raw NSImage/NSData cannot be
 *  accessed via this method.
 *
 *  @param application The application for which the screenshot will be taken.
 *  @param scale       Scale for the screenshot - the original screenshot will be resized by this amount. Typically less or equal than one.
 *
 *  @return A fully initialized KSScreenshotData object or nil, if the operation failed for some reason.
 */
+ (KSScreenshotData *)screenshotDataForApplication:(NSRunningApplication *)application
                                             scale:(CGFloat)scale;

@end
