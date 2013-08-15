//
//  NSArray+Addons.m
//  KnowSensor X
//
//  Created by Joerg Simon on 1/29/13.
//
//

#import "NSArray+Addons.h"

@implementation NSArray (Addons)

+ (NSArray*)arrayRepeatingObject:(NSObject*)object times:(NSUInteger)times
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:times];
    for (NSUInteger counter = 0; counter < times; counter++) {
        [array addObject:[object copy]];
    }
    return (NSArray*)[array copy]; // copy makes an inmutable copy...
}

@end
