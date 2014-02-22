//
//  KSEvent.m
//  KnowSensor X
//
//  Created by David Ganster on 26/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

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

- (NSString *)typeAsString
{
    return [KSEvent stringForType:self.type];
}

/// Convenience method to be called from anywhere without having to create an NSDateFormatter object.
- (NSString *)timestampAsString
{
    return [KSUtils dateAsString:self.timestamp];
}


@end
