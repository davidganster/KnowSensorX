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

/**
 *  Provides convenient high-level access to the KnowServer's API, providing finished-blocks
 *  for all calls.
 */
@interface KSAPIClient : NSObject


/// Indicates whether or not the server is reachable at the moment.
/// Will update whenever a message has been sent succesfully/with an error.
@property(nonatomic, assign, readonly) BOOL serverReachable;

/** Singleton-Accessor for the shared object. Only work through this object, don't create your own!
 * @return The shared client object.
 */
+ (KSAPIClient *)sharedClient;

/** Tells the API Client to start checking whether the server is up or down.
 Intervals between checks are chosen by the API Client itself.
 Notifications are sent when the reachability status changes.
 */
- (void)startCheckingForServerReachability;

/** Tells the API Client to stop checking whether the server is up or down.
 @note This does not stop notifications from different sources (all API calls will still generate down/up notifications)
 */
- (void)stopCheckingForServerReachability;

/** Asynchronously loads all projects and returns them as a parameter in the success-block if the call has been successful.
    In case of an error, the failure block will be called with an NSError object.
 @param success The block that will be called when the call has successfully returned. The NSArray will contain KSProject objects.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)loadProjectsWithSuccess:(void (^)(NSArray *projects))success
                        failure:(void (^)(NSError *error))failure;


/** Asynchronously creates a new project on the server. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @param project The project to be created on the server. The APIClient will convert the KSProject object into a suitable JSON format. project.projectID MUST be nil, as the server will create and return the id to be used (see success for more info)
 @param success The block that will be called when the call has successfully returned. newProjectID is returned by the server for use with the given KSProject object.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)createProject:(KSProject *)project
              success:(void (^)(NSString *newProjectID))success
              failure:(void (^)(NSError *error))failure;


/** Asynchronously loads all activities from 'distant past' to 'now' . In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @param success The block that will be called when the call has successfully returned. The array of all received KSAcitivites is passed as parameter.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)loadAllActivities:(void(^)(NSArray *activities))success
                  failure:(void (^)(NSError *error))failure;

/** Asynchronously loads the currently recording activity from the server. In case the call was successful, the success block will be called with the returned KSActivity as parameter. Otherwise, the failure block will be executed with the encountered error as parameter.
 @param success The block that will be called when the call has successfully returned. currentActivity will be a newly created KSActivity object containing the information that was extracted from the JSON response.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)loadActiveActivity:(void (^)(KSActivity *currentActivity))success
                   failure:(void (^)(NSError *error))failure;


/** Asynchronously sets the currently recording activity on the server to the given KSActivity object. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @param activity The activity object to be serialized and sent to the server. activity.activityID MUST be nil for this to work. The generated id will be returned from the server and passed in the success block.
 @param success The block that will be called when the call has successfully returned. newActivityID is returned by the server for use with the given KSActivity object.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)startRecordingActivity:(KSActivity *)activity
                       success:(void (^)(NSString *newActivityID))success
                       failure:(void (^)(NSError *error))failure;

/** Asynchronously stops the recording activity on the server using the given KSActivity object. The object's data has to match the currently active activity on the server. In case the call was successful, the success block will be called. Otherwise, the failure block will be executed with the encountered error as parameter.
 @param activity The activity whose recording will be stopped. Has to match the currently recording activity.
 @param success The block that will be called when the call has successfully returned. No parameters.
 @param failure The block that will be called in case the call was unsuccessful. The NSError will contain an error generated by AFNetworking.
 */
- (void)stopRecordingActivity:(KSActivity *)activity
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure;



/** Convenience API for sending a recorded Event to the server. The receiver object will decide how the event will be sent using one of the other public methods (sendGetFocusEvent, sendLoseFocusEvent, sendUserIdleStartEvent, sendUserIdleEndEvent).
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded FocusEvent to the server when an application GETS the focus
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendGetFocusEvent:(KSEvent *)event  finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded FocusEvent to the server when an application LOSES the focus
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendLoseFocusEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded IdleEvent to the server when the user STARTS to idle
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendUserIdleStartEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

/** API for sending a recorded IdleEvent to the server when the user STOPS to idle.
 * @param event The event to be sent to the server. It will be serialized into a JSON object. The finishedBlock will be called with the error, should the serialization fail.
 * @param finishedBlock The block to be executed when a response from the server has been received. It might contain an error if something went wrong.
 */
- (void)sendUserIdleEndEvent:(KSEvent *)event finished:(void (^)(NSError *error))finishedBlock;

@end
