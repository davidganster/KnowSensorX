//
//  KSImportable.h
//  KnowSensor X
//
//  Created by David Ganster on 22/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Simple protocol that defines a method to import the receiver values from a dictionary.
 *  The implementing class then needs to return `YES` if the import was successful,
 *  or `NO` if importing failed.
 */
@protocol KSImportable<NSObject>

/**
 *  Tells the receiver to import its values from the given non-nil dictionary.
 *
 *  @param dictionary The dictionary containing the new values for the receiver.
 *
 *  @return `YES` if import was successful, `NO` otherwise.
 */
- (BOOL)importValuesForKeysWithObject:(NSDictionary *)dictionary;

@end
