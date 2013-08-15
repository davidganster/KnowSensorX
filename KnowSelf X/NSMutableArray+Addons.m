//
//  NSMutableArray+Addons.m
//  KnowSensor X
//
//  Created by Joerg Simon on 8/2/12.
//
//

#import "NSMutableArray+Addons.h"

@implementation NSMutableArray (Addons)

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}
@end
