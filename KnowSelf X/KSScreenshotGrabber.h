//
//  KSScreenshotGrabber.h
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
