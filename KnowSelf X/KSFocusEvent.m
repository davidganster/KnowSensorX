//
//  KSFocusEvent.m
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSFocusEvent.h"
#import "KSScreenshotData.h"

@implementation KSFocusEvent

- (id)init
{
    self = [super init];
    if (self) {
        _windowhandle = @"";
        _runtimeID = @"";
    }
    return self;
}

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [[super dictRepresentation] mutableCopy];
    [dataDict setObject:self.filePath forKey:@"path"];
    [dataDict setObject:self.processID forKey:@"processid"];
    [dataDict setObject:self.processName forKey:@"processname"];
    [dataDict setObject:self.windowTitle forKey:@"windowtitle"];
    if(self.screenshot)
        [dataDict setObject:[self.screenshot dictRepresentation] forKey:@"screenshot"];
    else
        [dataDict setObject:[NSNull null] forKey:@"screenshot"];
    
    // unused keys:
    [dataDict setObject:self.runtimeID forKey:@"runtimeid"];
    [dataDict setObject:self.windowhandle forKey:@"windowhandle"];
    return dataDict;
}

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
