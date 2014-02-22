//
//  KSIdleEvent.m
//  KnowSensor X
//
//  Created by David Ganster on 18/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleEvent.h"


@implementation KSIdleEvent

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [[super dictRepresentation] mutableCopy];
    [dataDict setObject:self.timeOfRecording forKey:@"timestamp"];
    [dataDict setObject:self.idleSinceSeconds forKey:@"idlesinceseconds"];
    if(self.idleSinceTimestamp) {
        [dataDict setObject:self.idleSinceTimestamp forKey:@"idlesincetimestamps"];
    }
    return dataDict;
}

- (NSString *)application
{
    return @"Idle Sensor";
}

- (NSString *)description
{
    NSMutableString *description = [[super description] mutableCopy];
    [description appendFormat:@"idleSinceTimeStamp   = %@, ", self.idleSinceTimestamp];
    [description appendFormat:@"idleSinceSeconds = %@, ", self.idleSinceSeconds];
    return description;
}


@end
