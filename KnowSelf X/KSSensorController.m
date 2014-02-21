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
#import "KSEvent+Addons.h"
#import "KSUserInfo.h"

@interface KSSensorController ()

/// Used to store events until the server becomes reachable, and send them as soon as it becomes reachable again.
@property(nonatomic, strong) NSMutableArray *eventBuffer;

/// The queue which will be used to work on the eventBuffer.
@property(nonatomic, assign) dispatch_queue_t eventBufferQueue;

/// Flag that indicates that the queue is being emptied right now - meaning that the process is not going to be started again.
@property(nonatomic, assign) BOOL queueIsBeingEmptied;

/// Finished-blocks can be stored per event -
/// these blocks will be stored in this dictionary and called once the call in question successfully returns.
@property(nonatomic, strong) NSMutableDictionary *eventFinishedBlocks;

@end

@implementation KSSensorController

+ (KSSensorController *)sharedSensorController
{
    static KSSensorController *_sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [[KSSensorController alloc] init];
    });
    
    return _sharedController;

}

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(serverReachable)
                                                     name:kKSNotificationKeyServerReachable
                                                   object:nil];
    }
    return self;
}

- (BOOL)startRecordingEvents
{
    BOOL success = YES;
    for (KSSensor *sensor in self.sensors) {
        success &= [sensor startRecordingEvents];
    }
    
    LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Starting to record events %@.", success ? @" was successful" : @"FAILED");
    
    return success;
}

- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished
{
    static  NSEnumerator *enumerator = nil;
    if(!enumerator)
        enumerator = [self.sensors objectEnumerator];
    
    __block BOOL success = YES;
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

#pragma mark Server Reachability Listener
- (void)serverReachable
{
    dispatch_async(self.eventBufferQueue, ^{
        if(!self.queueIsBeingEmptied) {
            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Server is reachable, will start sending %lu remaining events!", [self.eventBuffer count]);
            self.queueIsBeingEmptied = YES;
            [self emptyQueue];
        }
    });
}

#pragma mark KSFocusSensorDelegate
- (NSString *)focusSensor:(KSFocusSensor *)sensor mappedNameForURL:(NSString *)recordedURL
{
    NSDictionary *dictionary = [[KSUserInfo sharedUserInfo] URLMappings];
    
    // At first, we check if there is an exact match in our table to ensure that
    // specific URLs are matched first.
    NSString *exactMatch = dictionary[recordedURL];
    if(exactMatch)
        return exactMatch;
    
    // If that didn't work, we want full regular expression matching:
    for (NSString *URLToMatch in [dictionary allKeys]) {
        if ([recordedURL rangeOfString:URLToMatch
                               options:NSRegularExpressionSearch].location != NSNotFound) {
//            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Replacing '%@' (matched by '%@') with '%@'.", recordedURL, URLToMatch, dictionary[URLToMatch]);
            return dictionary[URLToMatch];
        }
    }
    return recordedURL;
}

- (BOOL)focusSensor:(KSFocusSensor *)sensor shouldRecordApplication:(NSRunningApplication *)application
{
    BOOL ignoreApplication = NO;
    
    if([kKSFocusSensorBlockedApplicationNames containsObject:application.localizedName]) {
        LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Will ignore application %@", application.localizedName);
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
        if(![[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]) {
            // ... which means it isn't on the whitelist. We ignore this app!
            ignoreApplication = YES;
        }
    }
    return !ignoreApplication;
}

#pragma mark KSSensorDelegateProtocol

- (void)sensor:(KSSensor *) sensor didRecordEvent:(KSEvent *)event finished:(void (^)(BOOL success))finished;
{
    [self addEventBufferObject:event withFinishedBlock:finished];
}

- (void)addEventBufferObject:(KSEvent *)event withFinishedBlock:(void (^)(BOOL success))finished
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

- (void)emptyQueue
{
    dispatch_async(self.eventBufferQueue, ^{
        if([self.eventBuffer count]) {
            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"event buffer queue object count before starting: %lu", (unsigned long)[self.eventBuffer count]);
            KSEvent *currentEvent = nil;
            @try {
                currentEvent = self.eventBuffer[0];
            }
            @catch (NSException *exception)
            {
                LogMessage(@"bla", 1, @"asd");
            }
            @finally {
            }
            currentEvent = [currentEvent inContext:[NSManagedObjectContext contextForCurrentThread]];
            [[KSAPIClient sharedClient] sendEvent:currentEvent finished:^(NSError *error) {
                dispatch_async(self.eventBufferQueue, ^{
                    if(!error) {
                        KSEvent *event = nil;
                        @try {
                            event = self.eventBuffer[0];
                        }
                        @catch (NSException *exception)
                        {
                            LogMessage(@"bla", 1, @"asd");
                        }
                        @finally {
                            
                        }
                        event = [event inContext:[NSManagedObjectContext contextForCurrentThread]];
                        NSString *eventDescription = [event description];
                        if([self.eventFinishedBlocks objectForKey:eventDescription] != nil) {
                            void (^block)() = [self.eventFinishedBlocks objectForKey:eventDescription];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                block(YES);
                            });
                            [self.eventFinishedBlocks removeObjectForKey:eventDescription];
                        }
                        [self.eventBuffer removeObjectAtIndex:0];
                        LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"event buffer queue object count after removal: %lu", (unsigned long)[self.eventBuffer count]);
                        // delete event to save memory:
                        NSManagedObjectContext *context = event.managedObjectContext;
                        [context deleteObject:event];
                        [context processPendingChanges];
                        [context saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
                            if(context != [NSManagedObjectContext defaultContext]) {
                                [[NSManagedObjectContext defaultContext] deleteObject:event];
                                [[NSManagedObjectContext defaultContext] save:nil];
                            }
                        }];
                        
                        [self emptyQueue];
                    } else {
                        self.queueIsBeingEmptied = NO;
                        // do NOT remove object from queue, but wait until the server is available again.
                        LogMessage(kKSLogTagSensorController,
                                   kKSLogLevelError, @"Could not send event %@. Will try when the server is available again (or another event is generated).", self.eventBuffer[0]);
                    }
                });
            }];
        } else {
            LogMessage(kKSLogTagSensorController, kKSLogLevelDebug, @"Queue emptied.");
            self.queueIsBeingEmptied = NO;
        }
    });
}

@end
