//
//  KSProject.m
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

#import "KSProject.h"
#import "KSActivity.h"


@implementation KSProject

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    [dataDict setObject:self.color forKey:@"color"];
    // 'name' is entered by the user, so it might contain spaces - therefore, we need to
    // add percentage-escapes
    [dataDict setObject:[self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"name"];
    if(self.projectID) {
        [dataDict setObject:self.projectID forKey:@"id"];
    }
    return dataDict;
}

- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary
{
    self.color = dictionary[@"color"];
    self.name = [dictionary[@"name"] stringByRemovingPercentEncoding];
    self.projectID = dictionary[@"id"];
    // project ID is like 'http://www.know-center.tugraz.at/uico/2012/01/UGhvbmUgY2FsbA=='
    // (need to be careful to not backslash-escape those slashes)
    return self.color && self.name && self.projectID;
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[KSProject class]]) {
        return NO;
    }
    KSProject *other = (KSProject *)object;
    // projects cannot change at all, so it's sufficient to just check the project ID
    if([self.projectID isEqualToString:other.projectID])
        return YES;
    return NO;
}

@end
