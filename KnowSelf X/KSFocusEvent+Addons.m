//
//  KSFocusEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusEvent+Addons.h"
#import "KSFocusEvent+Properties.h"

@implementation KSFocusEvent (Addons)

- (void)awakeFromInsert
{
    // this is kind of a hack, but where else to fill these pointless fields?
    // the server expects them in the payload, so they have to be included.
    self.windowhandle = @"";
    self.runtimeID = @"";
}

// TODO: actually export the screenshot in one of those methods.
- (BOOL)exportScreenshotPath:(NSMutableDictionary *)result
{
    // TODO: refactor this mess of screenshots/screenshotPaths.
    
    // we use the internal screenShot property here, and only use the screenShotPath for later reference, in case we need it sometime...
    NSArray *keys = [NSArray arrayWithObject:@"NSImageCompressionFactor"];
    NSArray *objects = [NSArray arrayWithObject:@"1.0"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSImage *image = self.screenshot;
    
    id objectToSet = [NSNull null];
    if(image) {
        NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithData:[image TIFFRepresentation]];
        NSData *tiff_data = [imageRep representationUsingType:NSPNGFileType properties:dictionary];
        objectToSet = tiff_data ?: [NSNull null];
    }
    
    [result setObject:objectToSet forKey:@"screenshot"];
    
    return YES;
}

- (NSString *)application
{
    return self.processName;
}

@end
