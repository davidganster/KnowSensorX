//
//  KSUtils.h
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUtils : NSObject

+ (NSString *)dateAsString:(NSDate *)date;

+ (NSAppleEventDescriptor *)executeApplescriptWithName:(NSString *)scriptName
                                          functionName:(NSString *)functionName
                                             arguments:(NSArray *)args
                                       errorDictionary:(NSDictionary **)errorDict;
+ (BOOL)accessibilityPopupAvailable;

@end
