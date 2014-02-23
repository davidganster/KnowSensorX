//
//  KSScreenshotGrabber.m
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSScreenshotGrabber.h"
#import "NSImage+ProportionalScaling.h"
#import "KSScreenshotData.h"
#import "NSData-Base64Extensions.h"

@implementation KSScreenshotGrabber

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
        [data setWidthInPixel:@(screenshot.size.width)];
        [data setHeightInPixel:@(screenshot.size.height)];
        [data setImageFormat:@"jpg"];
        NSString *base64String = [screenShotData encodeBase64WithNewlines:NO];
        [data setPixelDataBase64Encoded:base64String];
        return data;
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
    if(windowID == 0) {
        LogMessage(kKSLogTagScreenshotGrabber, kKSLogLevelInfo, @"Could not find window for application with name: %@", appName);
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
