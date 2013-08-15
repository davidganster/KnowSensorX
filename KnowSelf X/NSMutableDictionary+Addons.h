//
//  NSMutableDictionary+Addons.h
//  KnowSensor X
//
//  Created by Joerg Simon on 7/31/12.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addons)

- (NSMutableDictionary *) mutableCopyWithoutNullValues;

@end

@interface NSMutableDictionary (Addons)

// used for the API to upload data
- (NSMutableDictionary *) dictWithoutNullValues;

@end
