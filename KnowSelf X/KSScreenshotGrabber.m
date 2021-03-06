//
//  KSScreenshotGrabber.m
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

#import "KSScreenshotGrabber.h"
#import "NSImage+ProportionalScaling.h"
#import "KSScreenshotData.h"
#import "NSData-Base64Extensions.h"

static BOOL isTinyWindow = NO;

@implementation KSScreenshotGrabber
/// @name Public methods
+ (KSScreenshotData *)screenshotDataForApplication:(NSRunningApplication *)application
                                             scale:(CGFloat)scale
{
    CGWindowID windowID = [KSScreenshotGrabber windowIDForAppName:application.localizedName];
    if(windowID) {
        NSImage *screenshot = [KSScreenshotGrabber takeScreenShotForWindowWithID:windowID
                                                                           scale:scale];
        NSData *screenShotData = [screenshot TIFFRepresentation];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:screenShotData];
        screenShotData = [imageRep representationUsingType:NSJPEGFileType
                                                properties:@{NSImageCompressionFactor : @(0.5)}];
        
        KSScreenshotData *data = [[KSScreenshotData alloc] init];
        CGFloat screenScale = [[NSScreen mainScreen] backingScaleFactor];
        [data setWidthInPixel:@(screenshot.size.width * screenScale)];
        [data setHeightInPixel:@(screenshot.size.height * screenScale)];
        [data setImageFormat:@"jpg"];
        NSString *base64String = [screenShotData encodeBase64WithNewlines:NO];
        [data setPixelDataBase64Encoded:base64String];
        return data;
    }
    return nil;
}

#pragma mark - Helper
/// @name Private helpers

/**
 *  Helper method that tries to identify the appropriate window ID for the given application name.
 *  It iterates through the list of all windows and returns the first one whose owner is equal
 *  to the given appName. 
 *  Since this is usually called from a getFocus event, the expected runtime is O(1), 
 *  because the window list is ordered front-to-back.
 *  Sometimes, an applications front window will be the status bar icon - in this case, the search
 *  will be continued until a larger window of the same application is found.
 *  (Skype is an example of an application that requires this workaround.)
 *  The attempt to retrieve the window ID will fail if the application doesn't have a window.
 *  In this case, the runtime will be O(n), where n is the number of open windows.
 *
 *  @param appName The name of the application, it will be used to search through the window list.
 *
 *  @return The window ID of the frontmost window of the given application name, or 0 if no window belonging to the application with the given name has been found.
 */
+ (CGWindowID)windowIDForAppName:(NSString *)appName
{
    // Ask the window server for the list of windows.
	CFArrayRef windowList = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
	
    NSMutableArray *windowListArray = CFBridgingRelease(windowList);
    
    CGWindowID windowID = 0;
    // list should be ordered, we just want to make sure we got the right one...
    for (NSDictionary *dict in windowListArray) {
        if([dict[@"kCGWindowOwnerName"] isEqualToString:appName]) {
            windowID = [dict[@"kCGWindowNumber"] unsignedIntValue];
            NSDictionary *boundsDict = dict[@"kCGWindowBounds"];
            int width  = [boundsDict[@"Width"]  intValue];
            int height = [boundsDict[@"Height"] intValue];
            if(width < 50 && height < 50) {
                // window is tiny... let's try to find a larger one
                // (it's possible that this is only a status bar icon)
                isTinyWindow = YES;
                continue;
            }
            isTinyWindow = NO;
            break;
        }
    }
//    if(windowID == 0) {
//        LogMessage(kKSLogTagScreenshotGrabber, kKSLogLevelInfo, @"Could not find window for application with name: %@", appName);
//    }
    return windowID;
}

/**
 *  Helper method that captures a screenshot for the given window ID, and
 *  scales it down by the given scale factor.
 *
 *  @param windowID The window ID for which to capture a screenshot.
 *  @param scale    The scale by which to scale the captures screenshot
 *
 *  @return An NSImage of the window with `windowID`, scaled down by `scale`, or nil if capturing the screenshot failed for some reason.
 */
+ (NSImage *)takeScreenShotForWindowWithID:(CGWindowID)windowID scale:(CGFloat)scale
{
    CGImageRef windowImage = CGWindowListCreateImage(CGRectNull, kCGWindowListOptionIncludingWindow, windowID, kCGWindowImageDefault);
    NSImage *screenshot = [[NSImage alloc] initWithCGImage:windowImage
                                                      size:NSZeroSize];
    if(!isTinyWindow) {
        screenshot = [screenshot imageByScalingProportionallyToSize:CGSizeMake(screenshot.size.width * scale,
                                                                               screenshot.size.height * scale)];
    }
    CGImageRelease(windowImage);
    return screenshot;
}

@end
