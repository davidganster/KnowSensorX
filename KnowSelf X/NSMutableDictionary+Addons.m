//
//  NSMutableDictionary+Addons.m
//  KnowSensor X
//
//  Created by Joerg Simon on 7/31/12.
//
//

#import "NSMutableDictionary+Addons.h"

static inline void MCRemoveNullValuesFromDict(NSMutableDictionary *dict)
{
    NSMutableArray *nullKeys = [[NSMutableArray alloc] init];
    for (NSString *key in dict.keyEnumerator) {
        id value = [dict objectForKey:key];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            [nullKeys addObject:key];
        }
    }
    [dict removeObjectsForKeys:nullKeys];
}

@implementation NSDictionary (Addons)

- (NSMutableDictionary *) mutableCopyWithoutNullValues
{
    NSMutableDictionary *returnValue = [self mutableCopy];
    MCRemoveNullValuesFromDict(returnValue);
    return returnValue;
}

@end

@implementation NSMutableDictionary (Addons)

- (NSMutableDictionary *) dictWithoutNullValues
{
    NSMutableDictionary *returnValue = [self mutableCopy];
    MCRemoveNullValuesFromDict(returnValue);
    return returnValue;
}

@end