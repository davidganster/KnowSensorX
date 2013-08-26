//
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
@property(nonatomic, strong) NSDate *lastDateBeforeIdle;
/// The return value of [NSEvent addGlobalMonitorForEventsMatchingMasks:handler:] must be saved somewhere because it cannot be retained by the handler:-block alone.
@property(nonatomic, strong) id eventHandler;

@end

@implementation KSIdleSensor

-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        _sensorID = kKSSensorIDIdleSensor;
        _name = kKSSensorNameIdleSensor;
        _minimumIdleTime = kKSIdleSensorMinimumIdleTime;
        _idleTimeSoFar = 0;
    }
    return self;
}

-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate andMinimumIdleTime:(CGFloat)idleTime
{
    self = [super initWithDelegate:delegate];
    if(self) {
        _sensorID = kKSSensorIDIdleSensor;
        _name = kKSSensorNameIdleSensor;
        _minimumIdleTime = idleTime;
        _idleTimeSoFar = 0;
    }
    return self;
}

- (void)createTimerWithFireDate:(NSDate *)fireDate
{
    // default value is the idle time of this object.
    if(!fireDate)
        fireDate = [NSDate dateWithTimeIntervalSinceNow:self.minimumIdleTime];
    self.idleTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.minimumIdleTime]
                                              interval:0.f
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
    if(actualIdleTime < self.minimumIdleTime + 0.1f ||
       actualIdleTime > self.minimumIdleTime - 0.1f) {
        // idle time almost matches our required time - since timers might be off by a bit, this is good enough.
        self.idleTimeSoFar = 0.f;
        
        KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleStart idleSinceSeconds:self.minimumIdleTime];
        self.lastDateBeforeIdle = [idleEvent timestamp]; // overly accurate?
        
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            [self.delegate sensor:self didRecordEvent:idleEvent];
        }];
        
        // now, we need to listen for when the idle ends. No timers are necessary in the meantime.
        [self registerForIdleEndEvents];
    } else if(actualIdleTime > self.minimumIdleTime) {
        NSLog(@"ERROR: something has gone wrong with the timing when testing for idle - the timer was off by %g seconds.",  self.minimumIdleTime - actualIdleTime);
    } else {
        if(self.idleTimeSoFar == 0.f)
            self.idleTimeSoFar = idleTime;
        else
            self.idleTimeSoFar = 0.f;
        
        [self createTimerWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.minimumIdleTime - self.idleTimeSoFar]];
    }
}

/// registers an eventHandler for any keyboard/mouse events, as those will end the user's idle.
- (void)registerForIdleEndEvents
{
    self.eventHandler = [NSEvent addGlobalMonitorForEventsMatchingMask:NSAnyEventMask handler:^(NSEvent *someEvent) {
        // we don't actually care about the event. this just means that the idle ended!
        [NSEvent removeMonitor:self.eventHandler];
        self.eventHandler = nil;
        self.idleTimeSoFar = 0.f; // just to be safe.
        // how long has it been since we started to idle?
        CFTimeInterval idledTime = -[self.lastDateBeforeIdle timeIntervalSinceNow];
        KSIdleEvent *idleEvent = [self createIdleEventWithType:KSEventTypeIdleEnd idleSinceSeconds:idledTime];
        [self.delegate sensor:self didRecordEvent:idleEvent];
        [self createTimerWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.minimumIdleTime]];
    }];
}

#pragma mark Helper
/// Creates an idle event with the given type (KSEventTypeIdleStart/KSEventTypeIdleEnd)
- (KSIdleEvent *)createIdleEventWithType:(KSEventType)type idleSinceSeconds:(CFTimeInterval)idleTime
{
    if(type != KSEventTypeIdleStart && type != KSEventTypeIdleEnd) {
        NSLog(@"ERROR: Can only create Idle event with type KSEventIdleStart or KSEventIdleEnd, not %i", type);
        return nil;
    }
    
    KSIdleEvent *idleEvent = [KSIdleEvent createInContext:[NSManagedObjectContext defaultContext]];
    [idleEvent setTimestamp:[NSDate date]];
    [idleEvent setType:type];
    [idleEvent setIdleSinceSeconds:@(idleTime)];
    [idleEvent setIdleSinceTimestamp:[NSDate dateWithTimeInterval:idleTime sinceDate:[NSDate date]]];
    return idleEvent;
}

@end

@implementation KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    [(KSIdleSensor *)self createTimerWithFireDate:nil];
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
    return NO;
}

@end
