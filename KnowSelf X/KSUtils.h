//
//  KSUtils.h
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUtils : NSObject

/**
 Converts the given date into a string using a NSDateFormatter. The date formatter is kept in memory since recreating it is slow. The date formatter is not customizable.
 */
+ (NSString *)dateAsString:(NSDate *)date;

/**
 Helper for easily executing an AppleScript file and obtaining its event descriptor.
 Loading and executing the script may take some time, so be sure to call this method on a background thread.
 */
+ (NSAppleEventDescriptor *)executeApplescriptWithName:(NSString *)scriptName
                                          functionName:(NSString *)functionName
                                             arguments:(NSArray *)args
                                       errorDictionary:(NSDictionary **)errorDict;
/**
 Checks whether or the the popup for changing accessability settings is available (OS X >= 10.9)
 */
+ (BOOL)accessibilityPopupAvailable;

/**
 Retrieves the NSUserDefaults bool 'isFirstStart' to check whether or not the program has been launched before.
 Will also automatically write 'YES' to the user defaults after the first start.
 */
+ (BOOL)isFirstStart;

static inline void KS_dispatch_async_reentrant(dispatch_queue_t queue, dispatch_block_t block)
{
    if(dispatch_get_current_queue() == queue) {
        block();
    } else {
        dispatch_async(queue, block);
    }
}

static inline void KS_dispatch_sync_reentrant(dispatch_queue_t queue, dispatch_block_t block)
{
    if(dispatch_get_current_queue() == queue) {
        block();
    } else {
        dispatch_sync(queue, block);
    }
}

@end
