//
//  KSScreenshotGrabber.m
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSScreenshotGrabber.h"
#import "NSImage+ProportionalScaling.h"

@implementation KSScreenshotGrabber

+ (NSData *)screenshotDataForApplication:(NSRunningApplication *)application scale:(CGFloat)scale
{
    // todo
    CGWindowID windowID = [KSScreenshotGrabber windowIDForAppName:application.localizedName];
    if(windowID) {
        NSImage *screenshot = [KSScreenshotGrabber takeScreenShotForWindowWithID:windowID scale:scale];
        NSData *screenShotData = [screenshot TIFFRepresentation];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:screenShotData];
        screenShotData = [imageRep representationUsingType:NSJPEGFileType
                                                properties:@{NSImageCompressionFactor : @(0.5)}];
        return screenShotData;

    }
    return nil;
}

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
            break;
        }
    }
    return windowID;
}

+ (NSImage *)takeScreenShotForWindowWithID:(CGWindowID)windowID scale:(CGFloat)scale
{
    CGImageRef windowImage = CGWindowListCreateImage(CGRectNull, kCGWindowListOptionIncludingWindow, windowID, kCGWindowImageDefault);
    NSImage *screenshot = [[NSImage alloc] initWithCGImage:windowImage
                                                      size:NSZeroSize];
    screenshot = [screenshot imageByScalingProportionallyToSize:CGSizeMake(screenshot.size.width * scale,
                                                                           screenshot.size.height * scale)];
    CGImageRelease(windowImage);
    return screenshot;
}

@end
