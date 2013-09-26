//
//  KSAPIClient.h
//  KnowSensor X
//
//  Created by David Ganster on 19/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSEvent;
@class KSActivity;
@class KSProject;

@interface KSAPIClient : NSObject

/** Singleton-Accessor for the shared object. Only work through this object, don't create your own!
 * @author David Ganster
 * @return The shared client object.
 */
+ (KSAPIClient *)sharedClient;

/** Asynchronously loads all projects and returns them as a parameter in the success-block if the call has been successful.
    In case of an error, the failure block will be called with an NSError object.
 @author David Ganster
 @param success The block that will be called when the call has successfully returned. The NSArray will contain KSProject objects.
 @param falure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)loadProjectsWithSuccess:(void(^)(NSArray *projects))success
                        failure:(void (^)(NSError *error))failure;


/** Asynchronously creates a new project on the server. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @author David Ganster
 @param project The project to be created on the server. The APIClient will convert the KSProject object into a suitable JSON format.
 @param success The block that will be called when the call has successfully returned. No parameters.
 @param falure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)createProject:(KSProject *)project
              success:(void(^)())success
              failure:(void (^)(NSError *error))failure;


/** Asynchronously loads the currently recording activity from the server. In case the call was successful, the success block will be called with the returned KSActivity as parameter. Otherwise, the failure block will be executed with the encountered error as parameter.
 @author David Ganster
 @param success The block that will be called when the call has successfully returned. currentActivity will be a newly created KSActivity object containing the information that was extracted from the JSON response.
 @param falure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)loadActiveActivity:(void(^)(KSActivity *currentActivity))success
                   failure:(void (^)(NSError *error))failure;


/** Asynchronously sets the currently recording activity on the server to the given KSActivity object. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @author David Ganster
 @param success The block that will be called when the call has successfully returned. No parameters.
 @param falure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)startRecordingActivity:(KSActivity *)activity
                       success:(void(^)())success
                       failure:(void (^)(NSError *error))failure;

/** Asynchronously stops the recording activity on the server using the given KSActivity object. The object's data has to match the currently active activity on the server. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @author David Ganster
 @param activity The activity whose recording will be stopped. Has to match the currently recording activity.
 @param success The block that will be called when the call has successfully returned. No parameters.
 @param falure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)stopRecordingActivity:(KSActivity *)activity
                      success:(void(^)())success
                      failure:(void (^)(NSError *error))failure;



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
