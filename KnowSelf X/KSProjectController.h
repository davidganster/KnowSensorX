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
@class KSProjectController;

/// Protocol for callbacks for any observers of project related events.
/// Multiple listeners can subscribe to these events, and the callbacks defined in this protocol
/// will be called on all of them in the order they were added.
/// Both methods are optional, as might not provide interesting information to some of the observers,
/// and are generally not necessary for execution.
@protocol KSProjectControllerEventObserver <NSObject>
@optional

/** Callback for when the list of projects has changed on the server. Activities will be connected with the given project lists.
 @param controller The controller object that initiated the change.
 @param addedProjects The projects that have been added since the last poll.
 @param deletedProjects The projects that have been deleted since the last poll.
 */
- (void)projectController:(KSProjectController *)controller projectListChangedWithAddedProjects:(NSArray *)addedObjects
          deletedProjects:(NSArray *)deletedProjects;


/** Callback for when the actively recording activity has changed on the server.
 @param activity The new active activity.
 */
- (void)projectController:(KSProjectController *)controller activeActivityChangedToActivity:(KSActivity *)activity;

@end

/// Singleton class that manages all server interactions regarding projects, e.g. getting/creating projects and activities.
/// Will listen for a kKSNotificationKeyServerReachable notification before becoming active.
/// The KSProjectController periodically asks the server for new projects and updates all observers when the list changes.
@interface KSProjectController : NSObject

/// Accessor to the singleton object.
+ (KSProjectController *)sharedProjectController;

/// Specifies the time interval between two polls for refreshing projects.
@property(nonatomic, assign) CFTimeInterval timeIntervalBetweenPolls;

/** Starts the polling loop for projects immediately, then polls every `timeInterval` seconds.
 @param timeIntervalInSeconds The time between two polls. More polls = more CPU/network activity, recommended value is about 5 seconds.
 */
- (void)startUpdatingProjectListWithTimeBetweenPolls:(CFTimeInterval)timeIntervalInSeconds;

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
 @param obsever The object to be removed from the list of observers for the project list.
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

/** Returns the active project list managed by the ProjectController. 
 Since no timestamp/creation date is known, projects are ordered in the way they are received from the server.
 Thread-safe.
 @return An NSArray of KSProject * objects.
 */
- (NSArray *)currentProjectList;


@end
