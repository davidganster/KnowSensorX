//
//  KSActivity.m
//  KnowSensor X
//
//  Created by David Ganster on 05/01/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSActivity.h"
#import "KSProject.h"


@implementation KSActivity

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    [dataDict setObject:self.name forKey:@"activity"];

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
    
    if(self.isStartingRecording) {
        [dataDict setObject:self.project.projectID forKey:@"project"];
    } else {
        [dataDict setObject:self.project.name forKey:@"project"];
    }
        
    return dataDict;
}


- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary
{
    self.activityID  = dictionary[@"id"];
    self.name        = dictionary[@"activity"];
    self.color       = dictionary[@"color"];
    NSString *startDateString = dictionary[@"start_date"];
    if([startDateString isEqual:[NSNull null]] || startDateString == nil) {
        self.startDate = nil;
    } else {
        self.startDate   = [KSUtils dateFromString:startDateString];
    }
    
    NSString *endDateString = dictionary[@"end_date"];
    if([endDateString isEqual:[NSNull null]] || endDateString == nil) {
        self.endDate = nil;
    } else {
        self.endDate   = [KSUtils dateFromString:endDateString];
    }
    self.projectName = dictionary[@"project"];
    return YES;
}

@end
