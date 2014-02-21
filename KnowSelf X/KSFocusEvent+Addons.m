//
//  KSFocusEvent+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusEvent+Addons.h"
#import "NSData-Base64Extensions.h"

@implementation KSFocusEvent (Addons)

- (void)awakeFromInsert
{
    // this is kind of a hack, but where else to fill these pointless fields?
    // the server expects them in the payload, so they have to be included.
    self.windowhandle = @"";
    self.runtimeID = @"";
}

//- (BOOL)exportScreenshot:(NSMutableDictionary *)result
//{
//    if(self.screenshot) {
//        // todo: which encoding do we need?!
//        NSMutableDictionary *imageDict = [NSMutableDictionary dictionary];
//        [imageDict setObject:@"jpg" forKey:@"imageFormat"];
//        NSString *screenshotAsString = [self.screenshot encodeBase64WithNewlines:NO];
//        [result setObject:screenshotAsString forKey:@"screenshot"];
//        return YES;
//        return YES;
//    }
//    return NO;
//}

- (NSString *)application
{
    return self.processName;
}


- (NSString *)description
{
    NSMutableString *description = [[super description] mutableCopy];
    [description appendFormat:@"processID   = %@, ", self.processID];
    [description appendFormat:@"processName = %@, ", self.processName];
    [description appendFormat:@"filePath    = %@, ", self.filePath];
    [description appendFormat:@"windowTitle = %@\n", self.windowTitle];
    return description;
}

@end
