//
//  KSProject.m
//  KnowSensor X
//
//  Created by David Ganster on 24/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSProject.h"
#import "KSActivity.h"


@implementation KSProject

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    [dataDict setObject:self.color forKey:@"color"];
    [dataDict setObject:self.name forKey:@"name"];
    if(self.projectID) {
        [dataDict setObject:self.projectID forKey:@"id"];
    }
    return dataDict;
}

- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary
{
    self.color = dictionary[@"color"];
    self.name = dictionary[@"name"];
    self.projectID = dictionary[@"id"];
    return self.color && self.name && self.projectID;
}

@end
