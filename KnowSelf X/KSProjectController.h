//
//  KSProjectController.h
//  KnowSensor X
//
//  Created by David Ganster on 17/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSProject;
@class KSActivity;

/// Protocol for callbacks for any observers of project related events.
/// Multiple listeners can subscribe to these events, and the callbacks defined in this protocol
/// will be called on all of them in the order they were added.
@protocol KSProjectControllerEventObserver <NSObject>

/** Callback for when the list of projects has changed on the server.
 @param newProjectList An array containing pointers to all KSProject objects that are currently handled by the server.
 */
- (void)projectListChanged:(NSArray *)newProjectList;

/** Callback for when the actively recording activity has changed on the server.
 @param activity The new active activity.
 */
- (void)activeActivityChangedToActivity:(KSActivity *)activity;

@end

/// Singleton class that manages all server interactions regarding projects, e.g. getting/creating projects and activities.
/// Will listen for a kKSNotificationKeyServerReachable notification before becoming active.
/// The KSProjectController periodically asks the server for new projects and updates all observers when the list changes.
@interface KSProjectController : NSObject

/// Accessor to the singleton object.
+ (KSProjectController *)sharedProjectController;

/** Starts the polling loop for projects immediately, then polls every `timeInterval` seconds.
 @param timeIntervalInSeconds The time between two polls. More polls = more CPU/network activity, recommended value is about 5 seconds.
 */
- (void)startUpdatingProjectListWithTimeInterval:(CFTimeInterval)timeIntervalInSeconds;

/** Stops the polling loop for projects. The currently queued poll will still be executed, but the next one will surely be cancelled.
 */
- (void)stopUpdatingProjectList;

/** Adds an object to the list of observers that will be notified when the project list changes.
 The list is updated periodically
 TODO: add configurable time interval for this.
 @param obsever The object to be added to the list of observers for the project list.
*/
- (void)addObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer;

/** Removes an object to the list of observers that will be notified when the project list changes.
 The list is updated periodically
 TODO: add configurable time interval for this.
 @param obsever The object to be added to the list of observers for the project list.
 */
- (void)removeObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer;

/** Facade for KSAPIClient - creates a new project on the server and 
    updates the document with the returned project ID.
 All observers will be notified on the main thread about the change.
 @param project The project to be created on the server.
*/
- (void)createProject:(KSProject *)project;

/** Starts the recording of an activity on the server.
 In case the server is already recording a different activity, it will be stopped before starting this one.
 If the given activity is the currently recording activity, this call will do nothing.
 All observers will be notified on the main thread about the change.
 @param activity The activity for which the recording should be started.
 */
- (void)startRecordingActivity:(KSActivity *)activity;

/** Stops the recording of an activity on the server.
 If the given activity is not the currently recording activity or no activity is being recorded at the time, this call will do nothing.
 Otherwise, the activity will be stopped.
 All observers will be notified on the main thread about the change.
 @param activity The activity for which the recording should be stopped.
 */
- (void)stopRecordingActivity:(KSActivity *)activity;


/** Returns the active project list managed by the ProjectController. Thread-safe.
 @return An NSArray of KSProject * objects.
 */
- (NSArray *)currentProjectList;

@end
