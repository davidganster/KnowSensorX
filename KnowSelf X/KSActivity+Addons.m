//
//  KSActivity+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSActivity+Addons.h"
#import "KSProject+Addons.h"

@implementation KSActivity (Addons)

+ (KSActivity *)createOrFetchWithData:(NSDictionary *)data
                            inContext:(NSManagedObjectContext *)context
{
    NSString *activityID = [data objectForKey:@"id"];
    if(!activityID) return nil; // no id = invalid object.
    
    KSActivity *activity = [KSActivity findFirstByAttribute:@"activityID"
                                                  withValue:activityID
                                                  inContext:context];
    if(!activity) {
        activity = [KSActivity createInContext:context];
        // basically, nothing can really change (name, associated project, color, start date) but endDate.
        // endDate is not important at all though, since we basically only care about the name and project.
        if(![activity importValuesForKeysWithObject:data])
            return nil;
    }
    return activity;
}

- (BOOL)exportProjectName:(NSMutableDictionary *)result
{
    // The server expects projectID when STARTING the recording of an activity, and projectNAME when STOPPING the recording.
    NSString *projectName = [self.isStartingRecording boolValue] ?  self.project.projectID : self.project.name;
    
    if(!projectName) return NO;
    
    [result setObject:projectName forKey:@"project"];
    return YES;
}


- (BOOL)exportStartDate:(NSMutableDictionary *)result
{
    NSString *startDateString = [KSUtils dateAsString:self.startDate];
    if(!startDateString) return NO;
    
    [result setObject:startDateString forKey:@"start_date"];
    return YES;
}

- (BOOL)exportEndDate:(NSMutableDictionary *)result
{
    NSString *endDateString = [KSUtils dateAsString:self.endDate];
    if(!endDateString) {
        [result setObject:@"null" forKey:@"end_date"];
    } else {
        [result setObject:endDateString forKey:@"end_date"];
    }
    return YES;
}


@end
