//
//  KSActivity.m
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

#import "KSActivity.h"
#import "KSProject.h"


@implementation KSActivity

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    [dataDict setObject:[self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"activity"];

    NSString *endDateString = [KSUtils dateAsString:self.endDate];
    if(endDateString) {
        [dataDict setObject:endDateString forKey:@"end_date"];
    } else {
        [dataDict setObject:@"null" forKey:@"end_date"];
    }
    
    NSString *startDateString = [KSUtils dateAsString:self.startDate];
    
    [dataDict setObject:startDateString forKey:@"start_date"];
    
    if(self.activityID) {
        [dataDict setObject:self.activityID forKey:@"id"];
    } else {
        [dataDict setObject:@"" forKey:@"id"];
    }
    
//    if(!self.isStartingRecording) {
        [dataDict setObject:self.project.projectID forKey:@"project"];
//    } else {
//        [dataDict setObject:self.project.name forKey:@"project"];
//    }
        
    return dataDict;
}


- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary
{
    self.activityID = [dictionary[@"id"      ] stringByRemovingPercentEncoding];
    self.name       = [dictionary[@"activity"] stringByRemovingPercentEncoding];
    self.color      = [dictionary[@"color"   ] stringByRemovingPercentEncoding];
    
    NSString *startDateString = dictionary[@"start_date"];
    if([startDateString isEqual:[NSNull null]] || startDateString == nil) {
        self.startDate = nil;
    } else {
        self.startDate = [KSUtils dateFromString:startDateString];
    }
    
    NSString *endDateString = dictionary[@"end_date"];
    if([endDateString isEqual:[NSNull null]] || endDateString == nil) {
        self.endDate = nil;
    } else {
        self.endDate = [KSUtils dateFromString:endDateString];
    }
    self.projectName = [dictionary[@"project"] stringByRemovingPercentEncoding];
    return YES;
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[KSActivity class]])
        return NO;
    
    KSActivity *other = (KSActivity *)object;
    // activities might change in their end dates:
    if([self.activityID isEqualToString:other.activityID] &&
       ([self.endDate isEqualToDate:other.endDate] ||
        self.endDate == other.endDate))
        return YES;
    return NO;
}

@end
