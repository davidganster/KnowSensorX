//
//  NSMutableIndexSet+Addons.h
//  KnowSensor X
//
//  Created by David Ganster on 11.09.12.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableIndexSet (Addons)
+ (NSMutableIndexSet*)indexSetFromArray:(NSArray*)indexArray;
- (NSArray*)arrayWithNSNumbers;
@end
