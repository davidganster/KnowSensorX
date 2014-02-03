
//  KSIdleSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleSensor.h"
#import "KSIdleEvent+Addons.h"

@interface KSIdleSensor ()

@property(nonatomic, strong) NSTimer *idleTimer;
@property(nonatomic, assign) CFTimeInterval idleTimeSoFar;
@property(nonatomic, strong) NSDate *idleStartDate;
@property(nonatomic, assign) BOOL userIsIdling;
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
    }
    return self;
}

- (id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate andMinimumIdleTime:(CGFloat)idleTime
{
    self = [super initWithDelegate:delegate];
    if(self) {
        _sensorID = kKSSensorIDIdleSensor;
        _name = kKSSensorNameIdleSensor;
        _minimumIdleTime = idleTime;
        _idleTimeSoFar = 0;
        _userIsIdling = NO;
    }
    return self;
}

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
}

- (void)checkUserIdleTime
{
    CFTimeInterval idleTime = CGEventSourceSecondsSinceLastEventType(kCGEventSourceStateCombinedSessionState,
                                                                     kCGAnyInputEventType);
    
    // that's not the actual idle time, since we might have had some idle time left from the last event.
    CFTimeInterval actualIdleTime = idleTime + self.idleTimeSoFar;
    if(actualIdleTime >= self.minimumIdleTime) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelDebug, @"User idle detected!");
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

- (void)handleUserIdleStart:(id)sender
{
    if(self.userIsIdling) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"User is already idling, will not send events again.");
        return; // nothing more to do - someone has already detected the idle.
    }
    
    // update our state
    [self.lock lock];
    self.userIsIdling = YES;
    [self.lock unlock];

    // update the timer
    self.idleTimeSoFar = 0.f;
    [self.idleTimer invalidate];
    self.idleTimer = nil;
    
    [self sendUserIdleStartEvent];
    [self registerForIdleEndEvents];
}

/// Registers an eventHandler for any keyboard/mouse events, as those will end the user's idle.
/// Specal keys (such as 'cmd' or 'shift') will not end the idle state, whereas regular keys (such as letters, numbers or punctuation) will.
- (void)registerForIdleEndEvents
{
    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Will try to register event handler for Key/Mouse events.");
    self.eventHandler = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask | NSMouseMovedMask)
                                                               handler:^(NSEvent *someEvent)
    {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Event handler detected idle wakeup from event: %@", someEvent);
        [self.lock lock];
        // user idle end was detected by the polling loop (pollIdleEnd)
        if(self.userIsIdling == NO) {
            [self.lock unlock];
            return;
        }
        [self handleIdleEnd];
        [self.lock unlock];
   }];
    
    // additionally to the event monitor, we also manually poll - the event monitor randomly fails sometimes.
    [self pollIdleEnd];
    
    if(self.eventHandler && self.userIsIdling) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Registering event handler succeeded, handler is:%@", self.eventHandler);
    } else {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelError, @"COULD NOT REGISTER FOR IDLE END EVENTS!!! WILL NOT RECOGNIZE IDLE TO PREVENT GOING INTO LIMBO.");
        [self createTimerWithTimeInterval:0.0];
    }
}

- (void)pollIdleEnd
{
    // user is no longer idling, no need to continue polling.
    if(!self.userIsIdling)
        return;
    
    CFTimeInterval idleTime = CGEventSourceSecondsSinceLastEventType(kCGEventSourceStateCombinedSessionState,
                                                                     kCGAnyInputEventType);
//    LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Polling for idle end, idle time: %f", idleTime);
    [self.lock lock];
    if(idleTime < self.minimumIdleTime && self.userIsIdling) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelInfo, @"Idle end detected through polling.");
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

/// Warning: you need to make sure that this method is only ever called ONCE per idle wakeup.
- (void)handleIdleEnd
{
    [NSEvent removeMonitor:self.eventHandler];
    self.eventHandler = nil;
    LogMessage(kKSLogTagIdleSensor, kKSLogLevelDebug, @"User Idle wakeup detected!");
    // user idle ended, but not recognized by the event handler.
    self.userIsIdling = NO;
    // how long has it been since we started to idle?
    CFTimeInterval idledTime = -[self.idleStartDate timeIntervalSinceNow];
    
    KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleEnd
                                          idleSinceSeconds:idledTime];
    
    [self.delegate sensor:self didRecordEvent:idleEvent];
    [self createTimerWithTimeInterval:self.minimumIdleTime];
    // post notification: other sensors should reactivate themselves now.
    [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyUserIdleEnd
                                                        object:nil];
}

- (void)sendUserIdleStartEvent
{
    // create the event
    KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleStart
                                          idleSinceSeconds:self.minimumIdleTime];
    self.idleStartDate = [idleEvent timestamp];
    
#ifndef kKSIsSaveToPersistentStoreDisabled
    [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
#endif
        
        [self.delegate sensor:self didRecordEvent:idleEvent];
        
#ifndef kKSIsSaveToPersistentStoreDisabled
    }];
#endif
    
    // post notification: other sensors can deactivate themselves now.
    [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyUserIdleStart
                                                        object:nil];
}

#pragma mark Helper
/// Creates an idle event with the given type (KSEventTypeIdleStart/KSEventTypeIdleEnd)
- (KSIdleEvent *)createIdleEventWithType:(KSEventType)type idleSinceSeconds:(CFTimeInterval)idleTime
{
    if(type != KSEventTypeIdleStart && type != KSEventTypeIdleEnd) {
        LogMessage(kKSLogTagIdleSensor, kKSLogLevelError, @"ERROR: Can only create Idle event with type KSEventIdleStart or KSEventIdleEnd, not %i", type);
        return nil;
    }
    
    KSIdleEvent *idleEvent = [KSIdleEvent createInContext:[NSManagedObjectContext defaultContext]];
    [idleEvent setType:type];
    [idleEvent setTimestamp:[NSDate date]];
    [idleEvent setTimeOfRecording:[NSDate date]];
    [idleEvent setIdleSinceSeconds:@(idleTime)];
    if(type == KSEventTypeIdleEnd) {
        [idleEvent setIdleSinceTimestamp:[NSDate dateWithTimeInterval:idleTime sinceDate:[NSDate date]]];
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
    
    return YES;
}

- (BOOL)_unregisterForEvents
{
    KSIdleSensor *selfAsSubclass = (KSIdleSensor *)self;
    if(selfAsSubclass.eventHandler) {
        [NSEvent removeMonitor:selfAsSubclass.eventHandler];
    }
    [selfAsSubclass.idleTimer invalidate];
    selfAsSubclass.idleTimer = nil;
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
                                                                  name:NSWorkspaceWillSleepNotification
                                                                object:nil];
    return YES;
}

@end
