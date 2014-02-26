//
//  KSSensorController.m
//  KnowSensor X
//
//  Created by David Ganster on 30/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensorController.h"
#import "KSIdleSensor.h"
#import "KSFocusSensor.h"
#import "KSAPIClient.h"
#import "KSEvent.h"
#import "KSUserInfo.h"

@interface KSSensorController ()

/// The queue which will be used to work on the eventBuffer.
@property(nonatomic, assign) dispatch_queue_t eventBufferQueue;

/// Used to store events until the server becomes reachable, and send them as soon as it becomes reachable again.
/// If the `waitForReachability` flag is set to NO, the KSSensorDelegate will
/// immediately try to send the event again in the case of an error.
@property(nonatomic, strong) NSMutableArray *eventBuffer;

/// Flag that indicates that the queue is being emptied right now - meaning that the process is not going to be started again.
/// This flag is strictly meant for internal use, and has to be set (and read) on the eventBufferQueue.
@property(nonatomic, assign) BOOL queueIsBeingEmptied;

/// Finished-blocks can be stored per event -
/// these blocks will be stored in this dictionary and called once the call in question successfully returns.
@property(nonatomic, strong) NSMutableDictionary *eventFinishedBlocks;

@end

@implementation KSSensorController

#pragma mark Public methods.
/// @name Public methods

+ (KSSensorController *)sharedSensorController
{
    static KSSensorController *_sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [[KSSensorController alloc] init];
    });
    
    return _sharedController;

}

- (void)setWaitForReachability:(BOOL)waitForReachability
{
    dispatch_async(self.eventBufferQueue, ^{
        _waitForReachability = waitForReachability;
    });
}

- (BOOL)startRecordingEvents
{
    BOOL success = YES;
    for (KSSensor *sensor in self.sensors) {
        success &= [sensor startRecordingEvents];
    }
    
    if(!success) {
        LogMessage(kKSLogTagSensorController, kKSLogLevelError, @"Starting to record events FAILED.");
    }
    
    return success;
}

- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished
{
    // Used to enumerate all sensors while looping - needs to be static because this method will be called multiple times.
    static  NSEnumerator *enumerator = nil;
    if(!enumerator)
        enumerator = [self.sensors objectEnumerator];
    
    __block BOOL success = YES;
    // This block is the actual loop: As the current sensor to stop recording events,
    // passing a finished block that will call this method again.
    // Once all sensors are done, the original finished block that was passed will be executed.
    void (^ loop)(BOOL successSoFar) = ^void(BOOL successSoFar) {
        success &= successSoFar;
        KSSensor *sensor = [enumerator nextObject];
        if(sensor) {
            [sensor stopRecordingEventsFinished:^(BOOL successful) {
                [self stopRecordingEventsFinished:finished];
            }];
        } else {
            enumerator = nil;
            if(finished)
                finished(success);
        }
    };
    
    loop(YES);
}

#pragma mark KSFocusSensorDelegate
/// @name KSFocusSensorDelegate methods

- (NSString *)focusSensor:(KSFocusSensor *)sensor mappedNameForURL:(NSString *)recordedURL
{
    NSDictionary *dictionary = [[KSUserInfo sharedUserInfo] URLMappings];
    
    // At first, we check if there is an exact match in our table to ensure that
    // specific URLs are matched first.
    NSString *exactMatch = dictionary[recordedURL];
    if(exactMatch)
        return exactMatch;
    
    // If that didn't work, we want full regular expression matching:
    NSRange bestRange;
    bestRange.location = NSNotFound;
    bestRange.length = 0;
    NSString *bestMatchingURL = nil;
    for (NSString *URLToMatch in [dictionary allKeys]) {
        NSRange currentRange = [recordedURL rangeOfString:URLToMatch
                                                  options:NSRegularExpressionSearch];
        if (currentRange.location != NSNotFound &&
            currentRange.length > bestRange.length) {
            bestRange = currentRange;
            bestMatchingURL = URLToMatch;
        }
    }
    
    if(bestMatchingURL) {
        return dictionary[bestMatchingURL];
    }
    // No match, just return the original URL.
    return recordedURL;
}

- (BOOL)focusSensor:(KSFocusSensor *)sensor shouldRecordApplication:(NSRunningApplication *)application
{
    BOOL ignoreApplication = NO;
    
    if([kKSFocusSensorBlockedApplicationNames containsObject:application.localizedName.lowercaseString]) {
//        LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Will ignore application %@", application.localizedName);
        return NO;
    }
    
    if([[[KSUserInfo sharedUserInfo] specialApplications] containsObject:[application.bundleURL absoluteString]]) {
        // specialApplications contains the previous app...
        if([[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]) {
            // ... which means it is on the blacklist. We ignore this app!
            ignoreApplication  = YES;
        }
    } else {
        // specialApplications does not contain the previous app...
        if(![[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist] &&
           [[[KSUserInfo sharedUserInfo] specialApplications] count]) {
            // ... that means it isn't on the whitelist (which isn't empty). We ignore this app!
            ignoreApplication = YES;
        }
    }
    return !ignoreApplication;
}

- (KSScreenshotQuality)focusSensor:(KSFocusSensor *)sensor
   screenshotQualityForApplication:(NSRunningApplication *)application
{
    // deciding per application is not supported at the moment.
    if(![[KSUserInfo sharedUserInfo] shouldRecordScreenshots]) {
        return KSScreenshotQualityNone;
    }
    return [[KSUserInfo sharedUserInfo] screenshotQuality];
}

#pragma mark KSSensorDelegateProtocol

- (void)sensor:(KSSensor *)sensor
didRecordEvent:(KSEvent *)event
      finished:(void (^)(BOOL success))finished;
{
    [self addEventBufferObject:event withFinishedBlock:finished];
}

#pragma mark Private methods
/// @name Private methods

/**
 *  Internal method.
 *  Designated initializer.
 *  @warning Do not create a KSSensorController on your own. Use the singleton acessor (`sharedSensorController`) instead.
 *
 *  @return The new, fully initialized KSSensorController.
 */
- (id)init
{
    self = [super init];
    if (self) {
        // init sensors:
        KSFocusSensor *focusSensor = [[KSFocusSensor alloc] initWithDelegate:self];
        [focusSensor setFocusDelegate:self];
        KSIdleSensor *idleSensor = [[KSIdleSensor alloc] initWithDelegate:self];
        idleSensor.minimumIdleTime = [[KSUserInfo sharedUserInfo] minimumIdleTime];
        _sensors = @[focusSensor, idleSensor];
        _eventBuffer = [NSMutableArray array];
        _eventBufferQueue = dispatch_queue_create("Event Buffer Queue", DISPATCH_QUEUE_SERIAL);
        _eventFinishedBlocks = [NSMutableDictionary dictionary];
        _waitForReachability = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(serverReachable)
                                                     name:kKSNotificationKeyServerReachable
                                                   object:nil];
    }
    return self;
}

/**
 *  Internal method.
 *  It is called upon receiving a kKSNotificationKeyServerReachable notification.
 *  If the eventBuffer is not being emptied right now, this will start emptying the queue.
 *  This behaviour is useful when waiting for the server to become reachable, and then sending
 *  all events that have been queued up.
 */
- (void)serverReachable
{
    dispatch_async(self.eventBufferQueue, ^{
        if(!self.queueIsBeingEmptied) {
//            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Server is reachable, will start sending %lu remaining events!", [self.eventBuffer count]);
            self.queueIsBeingEmptied = YES;
            [self emptyQueue];
        }
    });
}

/**
 *  Internal method.
 *  This method ensures that the events are sent in the order they are submitted.
 *  dispatch_async on a serial queue will enqueue the given operation at the end of
 *  the queue, ensuring correct execution order.
 *  (dispatch_async is equivalent to dispatch_barrier_async when used on a serial queue)
 *
 *  @param event    The event to be added to the eventBuffer.
 *  @param finished The block to be executed when the event has successfully been sent.
 */
- (void)addEventBufferObject:(KSEvent *)event
           withFinishedBlock:(void (^)(BOOL success))finished
{
    dispatch_async(self.eventBufferQueue, ^{
        [self.eventBuffer addObject:event];
        if(finished) {
            [self.eventFinishedBlocks setObject:[finished copy] forKey:[event description]];
        }
        if(!self.queueIsBeingEmptied) {
            self.queueIsBeingEmptied = YES;
            [self emptyQueue];
        }
    });
}

/**
 *  Internal method.
 *  Emptied the eventBuffer queue one by one, always removing the first (0th) element 
 *  of the array upon successful completion.
 *  If a finished-block has been issued for the successfully sent event, it will be called and removed from the list.
 *  In case of an error while sending the event, the `waitForReachability` flag is checked.
 *  If it evaluates to NO, the KSSensorController will immediately try sending the event again, 
 *  without waiting for reachability to change. This is useful when stopping the recording of events, 
 *  where we want to get our queue emptied as quickly as possible.
 *  If `waitForReachability` is YES, on the other hand, the process of emptying the 
 *  queue will be stopped until a `kKSNotificationKeyServerReachable` notification is received 
 *  or another event is added to the queue.
 */
- (void)emptyQueue
{
    dispatch_async(self.eventBufferQueue, ^{
        if([self.eventBuffer count]) {
//            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"event buffer queue object count before starting: %lu", (unsigned long)[self.eventBuffer count]);
            KSEvent *currentEvent = nil;
            currentEvent = self.eventBuffer[0];
            //currentEvent = [currentEvent inContext:[NSManagedObjectContext contextForCurrentThread]];
            [[KSAPIClient sharedClient] sendEvent:currentEvent finished:^(NSError *error) {
                dispatch_async(self.eventBufferQueue, ^{
                    if(!error) {
                        KSEvent *event = nil;
                        event = self.eventBuffer[0];
                        NSString *eventDescription = [event description];
                        if([self.eventFinishedBlocks objectForKey:eventDescription] != nil) {
                            void (^block)() = [self.eventFinishedBlocks objectForKey:eventDescription];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                block(YES);
                            });
                            [self.eventFinishedBlocks removeObjectForKey:eventDescription];
                        }
                        [self.eventBuffer removeObjectAtIndex:0];
//                        LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"event buffer queue object count after removal: %lu", (unsigned long)[self.eventBuffer count]);
                        [self emptyQueue];
                    } else {
                        if(!self.waitForReachability) {
                            [self emptyQueue];
                        } else {
                            self.queueIsBeingEmptied = NO;
                            // do NOT remove object from queue, but wait until the server is available again.
                            LogMessage(kKSLogTagSensorController,
                                       kKSLogLevelError, @"Could not send event %@. Will try when the server is available again (or another event is generated).", self.eventBuffer[0]);
                        }
                    }
                });
            }];
        } else {
//            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Queue emptied.");
            self.queueIsBeingEmptied = NO;
        }
    });
}

@end
