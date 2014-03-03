//
//  KSUtils.h
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Provides commonly used convenience methods that don't belong to any specific class.
 */
@interface KSUtils : NSObject

/**
 *  Used to get the string representation of the given date.
 *  An NSDateFormatter with the format string `yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'` will be used.
 *  @note The NSDateFormatter will only be initialized the first time this is called and is not customizable.
 *
 *  @param date The date to be converted to an NSString object.
 *
 *  @return A string representing the given date.
 */
+ (NSString *)dateAsString:(NSDate *)date;

/**
 *  Used to get the date representation of the given string.
 *  An NSDateFormatter with the format string `yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'` will be used.
 *  @note The NSDateFormatter will only be initialized the first time this is called and is not customizable.
 *
 *  @param string The string to be converted to an NSDate object.
 *
 *  @return A date representing the given string.
 */
+ (NSDate *)dateFromString:(NSString *)string;

/**
 *  Executes the apple script with the given `scriptName`, `functionName` and `args`.
 *  Any errors that occur either during execution or loading will be written to the `errorDict`.
 *  @note This method only searches inside the application's main bundle, so it cannot be used to
 *        execute scripts that are not included in the application.
 *  @warning Executing a script might take some time, so be sure to call this on a background thread.
 *
 *  @param scriptName   The file name script to be executed, without the extension.
 *  @param functionName The name of the function in the script to be executed.
 *  @param args         The arguments that will be passed to the executed function.
 *  @param errorDict    A pointer to a dictionary that will contain any errors that occured (or be nil after the method returns).
 *
 *  @return The NSAppleEventDescriptor obtained by executing the apple script.
 */
+ (NSAppleEventDescriptor *)executeApplescriptWithName:(NSString *)scriptName
                                          functionName:(NSString *)functionName
                                             arguments:(NSArray *)args
                                       errorDictionary:(NSDictionary **)errorDict;
/**
 *  Checks if the accessibility popup is available on this version of OS X (currently >= 10.9).
 *
 *  @return YES if the accessibility popup is available, NO otherwise.
 */
+ (BOOL)accessibilityPopupAvailable;

/**
 *  Checks if the app has been started before.
 *
 *  @return `YES` iff the app has not been started before.
 */
+ (BOOL)isFirstStart;

/**
 *  Returns a float that will be used to appropriately scale images.
 *  This method takes into consideration the screen scale (otherwise, images taken on
 *  retina-devices would be four times larger).
 *
 *  @param quality The given image quality
 *
 *  @return The factor by which the image should be scaled down.
 */
+ (CGFloat)scaleForScreenshotQuality:(KSScreenshotQuality)quality;


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
