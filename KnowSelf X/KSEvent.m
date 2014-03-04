//
//  KSEvent.m
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

#import "KSEvent.h"
#import "KSUtils.h"

@implementation KSEvent

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *timestamp = [KSUtils dateAsString:self.timestamp];
    [dict setObject:timestamp forKey:@"timestamp"];
    return dict;
}

- (NSString *)application
{
    NSAssert(NO, @"Subclass of KSEvent must overwrite '- (NSString *) application'.");
    return nil;
}

- (NSString *)typeAsString
{
    return [KSEvent stringForType:self.type];
}

/// Convenience method to be called from anywhere without having to create an NSDateFormatter object.
- (NSString *)timestampAsString
{
    return [KSUtils dateAsString:self.timestamp];
}

+ (NSString *)stringForType:(KSEventType)type
{
    switch (type) {
        case KSEventTypeDidGetFocus:
            return kKSEventTypeDidGetFocus;
        case KSEventTypeDidLoseFocus:
            return kKSEventTypeDidLoseFocus;
        case KSEventTypeIdleStart:
            return kKSEventTypeDidStartIdle;
        case KSEventTypeIdleEnd:
            return kKSEventTypeDidEndIdle;
        default:
            return @"unknown type";
            break;
    }
}

@end
