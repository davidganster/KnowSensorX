//
//  KSActivity+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSActivity+Addons.h"

@implementation KSActivity (Addons)

+ (KSActivity *)createOrFetchWithData:(NSDictionary *)data
                           inContext:(NSManagedObjectContext *)context
{
    NSString *activityID = [data objectForKey:@"id"];
    if(!activityID) return nil; // no id = no valid object.
    
    KSActivity *activity = [KSActivity findFirstByAttribute:@"activityID"
                                                  withValue:activityID
                                                  inContext:context];
    if(!activity) {
        activity = [KSActivity createInContext:context];
    }
    // color might have changed (?), need to reimport at least that...
    // ...so why not just import everything at once for future-proofing?
    if(![activity importValuesForKeysWithObject:data])
        return nil;
    
    return activity;
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
    if(!endDateString) return NO;
    
    [result setObject:endDateString forKey:@"end_date"];
    return YES;
}


@end
