//
//  KSFocusEvent.m
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
    
    NSString *filePathWithoutPercentEncoding = [self.filePath stringByRemovingPercentEncoding];
    if(filePathWithoutPercentEncoding) {
        [dataDict setObject:filePathWithoutPercentEncoding forKey:@"path"];
    } else {
        [dataDict setObject:@"" forKey:@"path"];
    }
    
    [dataDict setObject:self.processID  forKey:@"processid"];
    [dataDict setObject:[self.processName stringByRemovingPercentEncoding] forKey:@"processname"];
    
    NSString *windowTitleWithoutPercentEncoding = [self.windowTitle stringByRemovingPercentEncoding];
    if(windowTitleWithoutPercentEncoding) {
        [dataDict setObject:windowTitleWithoutPercentEncoding forKey:@"windowtitle"];
    } else {
        [dataDict setObject:@"" forKey:@"windowtitle"];
    }
    
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
