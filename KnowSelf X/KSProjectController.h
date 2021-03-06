//
//  KSProjectController.h
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

@class KSProject;
@class KSActivity;
@class KSProjectController;

/// Protocol for callbacks for any observers of project related events.
/// Multiple listeners can subscribe to these events, and the callbacks defined in this protocol
/// will be called on all of them in the order they were added.
/// Both methods are optional, as they might not provide interesting information to some of the observers,
/// and are generally not required for proper execution of logic in the KSProjectController.
@protocol KSProjectControllerEventObserver <NSObject>
@optional

/** 
 *  Callback for when the list of projects has changed on the server. Activities will be connected with the given project lists.
 *  @param controller The controller object that initiated the change.
 *  @param addedProjects The projects that have been added since the last poll.
 *  @param deletedProjects The projects that have been deleted since the last poll.
 */
- (void)projectController:(KSProjectController *)controller projectListChangedWithAddedProjects:(NSArray *)addedObjects
          deletedProjects:(NSArray *)deletedProjects;


/** 
 *  Callback for when the actively recording activity has changed on the server.
 *  @param activity The new active activity.
 */
- (void)projectController:(KSProjectController *)controller activeActivityChangedToActivity:(KSActivity *)activity;

@end

/// Singleton class that manages all server interactions regarding projects, e.g. getting/creating projects and activities.
/// Will listen for a `kKSNotificationKeyServerReachable` notification before becoming active.
/// The `KSProjectController` periodically asks the server for new projects and updates all observers when the list changes.
@interface KSProjectController : NSObject

///@name Public methods

/// Accessor to the singleton object.
+ (KSProjectController *)sharedProjectController;

/// Specifies the time interval between two polls for refreshing projects.
@property(nonatomic, assign) CFTimeInterval timeIntervalBetweenPolls;

/// The activity that is currently recording. Will be updated whenever start/stopRecordingActivity: is called.
@property(nonatomic, strong) KSActivity *currentlyRecordingActivity;

/** Starts the polling loop for projects immediately, then polls every `timeInterval` seconds.
 @param timeIntervalInSeconds The time between two polls. More polls = more CPU/network activity, recommended value is about 5 seconds.
 */
- (void)startUpdatingProjectListWithTimeBetweenPolls:(CFTimeInterval)timeIntervalInSeconds;

/** Stops the polling loop for projects. The currently queued poll will still be executed, but the next one will surely be cancelled.
 */
- (void)stopUpdatingProjectList;

/** Adds an object to the list of observers that will be notified when the project list changes.
 The list is updated periodically
 @param observer The object to be added to the list of observers for the project list.
*/
- (void)addObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer;

/** Removes an object to the list of observers that will be notified when the project list changes.
 The list is updated periodically
 @param observer The object to be removed from the list of observers for the project list.
 */
- (void)removeObserverForProjectRelatedEvents:(id<KSProjectControllerEventObserver>)observer;

/** Asynchronous Facade for KSAPIClient - creates a new project on the server and
    updates the document with the returned project ID.
 All observers will be notified on the main thread about the change.
 @param project The project to be created on the server.
*/
- (void)createProject:(KSProject *)project;

/** Asynchronous Facade for KSAPIClient  - creates a new project on the server and
 updates the document with the returned project ID.
 All observers will be notified on the main thread about the change.
 @param project The project to be created on the server.
 @param success The block to be executed if the call has been successful
 @param failure The block to be executed if the call has failed
 */
- (void)createProject:(KSProject *)project
              success:(void (^)())success
              failure:(void (^)(NSError *error))failure;


/**
 *  Starts the recording of an activity on the server.
 *  In case the server is already recording a different activity, it will be stopped before starting this one.
 *  All observers will be notified on the main thread about the change.
 *
 *  @param activity The activity to be recorded.
 */
- (void)startRecordingActivity:(KSActivity *)activity;

/** Stops the recording of the active activity on the server.
 Otherwise, the activity will be stopped.
 All observers will be notified on the main thread about the change.
 @param success The block to be executed in case of success.
 @param failure The block to be executed in case of failure. An NSError object describing the reason is passed.
 */
- (void)stopRecordingCurrentActivitySuccess:(void (^)())success
                                    failure:(void (^)(NSError *error))failure;

/** Returns the active project list managed by the ProjectController. 
 Since no timestamp/creation date is known, projects are ordered in the way they are received from the server.
 Thread-safe.
 @return An NSArray of KSProject * objects.
 */
- (NSArray *)currentProjectList;



@end
