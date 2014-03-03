
//  KSIdleSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleSensor.h"
#import "KSIdleEvent.h"
#import "KSIdleTimeHelper.h"

@interface KSIdleSensor ()
/// The timer that fires every `minimumIdleTime` seconds and checks for the user idle time.
/// The timer might fire earlier if the user has already been idle for some time (but not enough
/// to be recognized as 'idle'.
@property(nonatomic, strong) NSTimer *idleTimer;
/// The time the user has been idle since the last checked. Will be substracted from
/// minimumIdleTime to get the next fireDate for the idleTimer.
@property(nonatomic, assign) CFTimeInterval idleTimeSoFar;
/// NSDate object indicating when the user has entered the 'idle' state.
@property(nonatomic, strong) NSDate *idleStartDate;
/// Indicates if the user is already idling. Needed for some internal logic (we don't want
/// to record idle end/start events more than once).
@property(nonatomic, assign) BOOL userIsIdling;
/// Instead of a serial queue, a standard lock is used to synchronize access to the important
/// properties (like `userIsIdling`).
@property(nonatomic, strong) NSLock *lock;
/// The return value of [NSEvent addGlobalMonitorForEventsMatchingMasks:handler:] must be saved somewhere because it cannot be retained by the handler:-block alone.
@property(nonatomic, strong) id eventHandler;

@end

@implementation KSIdleSensor

- (id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        _sensorID = kKSSensorIDIdleSensor;
        _name = kKSSensorNameIdleSensor;
        _minimumIdleTime = kKSIdleSensorMinimumIdleTime;
        _idleTimeSoFar = 0;
        _userIsIdling = NO;
        _lock = [[NSLock alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(idleTimeChanged:)
                                                     name:kKSNotificationKeyIdleTimeChanged
                                                   object:nil];
    }
    return self;
}

/**
 *  Listener for kKSNotificationKeyIdleTimeChanged.
 *  Resets the timer and sets minimumIdleTime to the notification's
 *  `kKSNotificationUserInfoKeyNewIdleTime` value (expected to be in seconds).
 *  Starts a new timer with the new minimumIdleTime.
 *
 *  @param notification The notification containing the new idle time in its userInfo dictionary.
 */
- (void)idleTimeChanged:(NSNotification *)notification
{
    [self.lock lock];
    self.minimumIdleTime = [notification.userInfo[kKSNotificationUserInfoKeyNewIdleTime] floatValue];
    [self.idleTimer invalidate];
    self.idleTimer = nil;
    [self.lock unlock];
    [self createTimerWithTimeInterval:0];
}

/**
 *  Starts a new timer to listen for user idle. 
 *  On OS X >= 10.9, a tolerance of one second will be applied to the timer to save energy.
 *  This is where the one-second-resolution of the KSIdleSensor happens.
 *
 *  @param timeInterval The time interval after which to fire the timer.
 */
- (void)createTimerWithTimeInterval:(CFTimeInterval)timeInterval
{
    // default value is the idle time of this object.
    if(!timeInterval)
        timeInterval = self.minimumIdleTime;
//    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Now listening for user idle with minimum idle time: %g", timeInterval);
    self.userIsIdling = NO;
    self.idleTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                      target:self
                                                    selector:@selector(checkUserIdleTime)
                                                    userInfo:nil
                                                     repeats:NO];
    // OS X >= 10.9 power savings improvement:
    if([self.idleTimer respondsToSelector:@selector(setTolerance:)]) {
        [self.idleTimer setTolerance:1.0f]; // even one second tolerance will improve power savings.
    }
}

/**
 *  Checks the time since the last user input and reacts accordingly:
 *  If the idleTime is larger than `minimumIdleTime`, an idleStart event will be sent,
 *  and the KSIdleSensor will start listening for idleEnd events.
 */
- (void)checkUserIdleTime
{
    CFTimeInterval idleTime = SystemIdleTime();
    // that's not the actual idle time, since we might have had some idle time left from the last event.
    CFTimeInterval actualIdleTime = idleTime + self.idleTimeSoFar;
    if(actualIdleTime >= self.minimumIdleTime) {
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"User idle detected!");
        // now, we need to listen for when the idle ends.
        // No more timers are necessary in the meantime.
        [self handleUserIdleStart:nil];
    } else {
        // not quite there yet - calculate how much time is missing for idle and check again in that amount of time.
        if(self.idleTimeSoFar == 0.f)
            self.idleTimeSoFar = idleTime;
        else
            self.idleTimeSoFar = 0.f;
        
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"User idled %g seconds so far. Will wait another %g seconds and then check again.", actualIdleTime, self.minimumIdleTime - actualIdleTime);
        [self createTimerWithTimeInterval:self.minimumIdleTime - actualIdleTime];
    }
}

/**
 *  Handles the start of the user idling.
 *  Stops the idle timer and registers for idle-end events.
 *  Does nothing if the user is already idling.
 *
 *  @param sender The notification that invoked the method or nil. If the sender is a notification, the KSIdleSensor will not start listening for idle-end events.
 */
- (void)handleUserIdleStart:(id)sender
{
    if(self.userIsIdling) {
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"User is already idling, will not send events again.");
        return; // nothing more to do - someone has already detected the idle.
    }
    
    // update our state
    [self.lock lock];
    self.userIsIdling = YES;

    // update the timer
    self.idleTimeSoFar = 0.f;
    [self.idleTimer invalidate];
    self.idleTimer = nil;
    [self.lock unlock];
    
    [self sendUserIdleStartEvent];
    // if the sender was a 'NSWorkspaceWillSleep' notification, we don't want to register idle end events -
    // because some other event might occur right before when the system goes to sleep (in which case the idle time is 0)
    if(![sender isKindOfClass:[NSNotification class]]) {
        [self registerForIdleEndEvents];
    }
}

/**
 *  Registers an eventHandler for any keyboard/mouse events, as those will end the user's idle.
 *  Specal keys (such as 'cmd' or 'shift') will not end the idle state, whereas 
 *  regular keys (such as letters, numbers or punctuation) will.
 *  Sometimes, the event handler will not register any events at all - as a fallback,
 *  another timer is started that continuously checks the idle time every 10 seconds.
 */
- (void)registerForIdleEndEvents
{
    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Will try to register event handler for Key/Mouse events.");
    self.eventHandler = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask | NSMouseMovedMask)
                                                               handler:^(NSEvent *someEvent)
    {
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Event handler detected idle wakeup from event: %@", someEvent);
        [self.lock lock];
        // user idle end was detected by the polling loop (pollIdleEnd)
        if(self.userIsIdling == NO) {
            [NSEvent removeMonitor:self.eventHandler];
            self.eventHandler = nil;
//            LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Event handler was too late, user is already active.");
            [self.lock unlock];
            return;
        }
        [self handleIdleEnd];
        [self.lock unlock];
   }];
    
    // additionally to the event monitor, we also manually poll - the event monitor randomly fails sometimes.
    [self pollIdleEnd];
    
    if(self.eventHandler && self.userIsIdling) {
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Registering event handler succeeded, handler is:%@", self.eventHandler);
    } else {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelError, @"COULD NOT REGISTER FOR IDLE END EVENTS!!! WILL NOT RECOGNIZE IDLE TO PREVENT GOING INTO LIMBO.");
        [self createTimerWithTimeInterval:0.0];
    }
}

/**
 *  Polls the idle time every kKSIdleSensorRegisterIdleEndPollInterval seconds (10.f seconds 
 *  as of this writing).
 *  Calls handleIdleEnd if the idleTime gets smaller and the user is still idling (idle
 *  end might have been registered by the eventHandler already).
 */
- (void)pollIdleEnd
{
    // user is no longer idling, no need to continue polling.
    if(!self.userIsIdling)
        return;
    
    CFTimeInterval idleTime = SystemIdleTime();
//    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Polling for idle end, idle time: %f", idleTime);
    [self.lock lock];
    if(idleTime < self.minimumIdleTime && self.userIsIdling) {
//        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Idle end detected through polling.");
        [self handleIdleEnd];
        [self.lock unlock];
        return;
    }
    
    [self.lock unlock];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kKSIdleSensorRegisterIdleEndPollInterval * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self pollIdleEnd];
    });
}



/**
 *  Removes the eventMonitor, sets userIsIdling to NO, hands a userIdleEnd event to the delegate,
 *  emits a `kKSNotificationKeyUserIdleEnd` and starts polling for idle time again.
 *
 *  @warning: You need to make sure that this method is only ever called *once* per idle wakeup, and you have to hold the lock when calling it.
 */
- (void)handleIdleEnd
{
    if(self.eventHandler) {
        [NSEvent removeMonitor:self.eventHandler];
        self.eventHandler = nil;
    }
    
//    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"User Idle wakeup detected!");
    // user idle ended, but not recognized by the event handler.
    self.userIsIdling = NO;
    // how long has it been since we started to idle?
    CFTimeInterval idledTime = -[self.idleStartDate timeIntervalSinceNow];
    
    KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleEnd
                                          idleSinceSeconds:idledTime];
    
    [self.delegate sensor:self didRecordEvent:idleEvent finished:^(BOOL success){
        [self createTimerWithTimeInterval:self.minimumIdleTime];
        // post notification: other sensors should reactivate themselves now.
        [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyUserIdleEnd
                                                            object:nil];
    }];
}

/**
 *  Creates a KSIdleEvent of type `KSEventTypeIdleStart` and hands it to the delegate.
 *  Emits a `kKSNotificationKeyUserIdleEnd` notification.
 *
 */
- (void)sendUserIdleStartEvent
{
    // create the event
    KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleStart
                                          idleSinceSeconds:self.minimumIdleTime];
    self.idleStartDate = [idleEvent timestamp];

    [self.delegate sensor:self didRecordEvent:idleEvent finished:nil];
    // post notification: other sensors can deactivate themselves now.
    [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyUserIdleStart
                                                        object:nil];
}

#pragma mark Helper
/**
 *  Creates and returns an idle event with the given type (`KSEventTypeIdleStart`/`KSEventTypeIdleEnd`).
 *
 *  @param type     The type of the event to be created.
 *  @param idleTime How long the user has already been idle.
 *
 *  @return A new instance of KSIdleEvent, initialized to the current date, and with the given information.
 */
- (KSIdleEvent *)createIdleEventWithType:(KSEventType)type
                        idleSinceSeconds:(CFTimeInterval)idleTime
{
    if(type != KSEventTypeIdleStart && type != KSEventTypeIdleEnd) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelError, @"ERROR: Can only create Idle event with type KSEventIdleStart or KSEventIdleEnd, not %i", type);
        return nil;
    }
    
    KSIdleEvent *idleEvent = [[KSIdleEvent alloc] init];
    [idleEvent setType:type];
    [idleEvent setTimestamp:[NSDate date]];
    [idleEvent setTimeOfRecording:[NSDate date]];
    [idleEvent setIdleSinceSeconds:@(idleTime)];
    if(type == KSEventTypeIdleEnd) {
        [idleEvent setIdleSinceTimestamp:[NSDate dateWithTimeInterval:-idleTime
                                                            sinceDate:[NSDate date]]];
    }
    [idleEvent setSensorID:self.sensorID];
    return idleEvent;
}

@end

@implementation KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    [(KSIdleSensor *)self createTimerWithTimeInterval:0];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(handleUserIdleStart:)
                                                               name:NSWorkspaceWillSleepNotification
                                                             object:nil];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(handleIdleEnd)
                                                               name:NSWorkspaceDidWakeNotification
                                                             object:nil];
    
    return YES;
}

- (void)_unregisterForEventsFinished:(void (^)(BOOL successful))finished
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
                                                                  name:NSWorkspaceWillSleepNotification
                                                                object:nil];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
                                                                  name:NSWorkspaceDidWakeNotification
                                                                object:nil];

    KSIdleSensor *selfAsSubclass = (KSIdleSensor *)self;
    [selfAsSubclass.lock lock];
    if(selfAsSubclass.eventHandler) {
        [NSEvent removeMonitor:selfAsSubclass.eventHandler];
    }
    [selfAsSubclass.idleTimer invalidate];
    selfAsSubclass.idleTimer = nil;
    
    // user might just be idling (if this is a scheduled shutdown)
    if(selfAsSubclass.userIsIdling) {
        // no more idleEnd-events will be recognized if 'userIsIdling' is NO.
        selfAsSubclass.userIsIdling = NO;
        [selfAsSubclass.lock unlock];
        CFTimeInterval idledTime = -[selfAsSubclass.idleStartDate timeIntervalSinceNow];
        
        KSIdleEvent *idleEvent = [selfAsSubclass createIdleEventWithType:KSEventTypeIdleEnd
                                                        idleSinceSeconds:idledTime];
        [selfAsSubclass.delegate sensor:self
                         didRecordEvent:idleEvent
                               finished:^(BOOL success) {
                                   finished(success);
        }];

    } else {
        [selfAsSubclass.lock unlock];
        finished(YES);
    }
}

@end
