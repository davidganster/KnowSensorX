//
//  KSProject+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 25/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSProject+Addons.h"

@implementation KSProject (Addons)

+ (KSProject *) createOrFetchWithData:(NSDictionary *)data
                            inContext:(NSManagedObjectContext *)context
{
    NSString *projectID = [data objectForKey:@"id"];
    KSProject *project = [KSProject findFirstByAttribute:@"projectID"
                                               withValue:projectID
                                               inContext:context];
    if(!project) {
        project = [KSProject createInContext:context];
    }
    // color might have changed, need to reimport at least that...
    // ...so why not just import everything at once for future-proofing?
    if(![project importValuesForKeysWithObject:data])
        return nil;
    
    return project;
}

@end
