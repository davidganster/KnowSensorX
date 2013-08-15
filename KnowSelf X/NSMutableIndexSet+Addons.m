//
//  NSMutableIndexSet+Addons.m
//  KnowSensor X
//
//  Created by David Ganster on 11.09.12.
//
//

#import "NSMutableIndexSet+Addons.h"


@implementation NSMutableIndexSet (Addons)

+ (NSMutableIndexSet*)indexSetFromArray:(NSArray*)indexArray
{
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
    for (NSNumber *num in indexArray) {
        [set addIndex:[num unsignedIntegerValue]];
    }
    return set;
}

- (NSArray*)arrayWithNSNumbers
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.count];
    NSUInteger currentVal = [self firstIndex];
    while (currentVal != NSNotFound) {
        [array addObject:@(currentVal)];
        currentVal = [self indexGreaterThanIndex:currentVal];
    }
    return array;
}

@end
