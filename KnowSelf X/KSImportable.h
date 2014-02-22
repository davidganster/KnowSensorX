//
//  KSImportable.h
//  KnowSensor X
//
//  Created by David Ganster on 22/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KSImportable<NSObject>

- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary;

@end
