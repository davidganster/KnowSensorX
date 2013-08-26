//
//  KSAPIClient.h
//  KnowSensor X
//
//  Created by David Ganster on 19/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSEvent;

@interface KSAPIClient : NSObject

/** Singleton-Accessor for the shared object. Only work through this object, don't create your own!
 * @author David Ganster
 * @return The shared client object.
 */
+ (KSAPIClient *)sharedClient;

/** Convenience API for sending a recorded Event to the server. The receiver object will decide how the event will be sent using one of the other public methods (sendGetFocusEvent, sendLoseFocusEvent, sendUserIdleStartEvent, sendUserIdleEndEvent).
 * @author David Ganster
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendEvent:(KSEvent *)event finished:(void (^)(NSError *error))block;

/** API for sending a recorded FocusEvent to the server when an application GETS the focus
 * @author David Ganster
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendGetFocusEvent:(KSEvent *)event  finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded FocusEvent to the server when an application LOSES the focus
 * @author David Ganster
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendLoseFocusEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded IdleEvent to the server when the user STARTS to idle
 * @author David Ganster
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendUserIdleStartEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded IdleEvent to the server when the user STOPS to idle.
 * @author David Ganster
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendUserIdleEndEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

@end
