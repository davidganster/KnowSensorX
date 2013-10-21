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
