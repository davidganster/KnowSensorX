//
//  KSSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensor.h"


@implementation KSSensor

- (id)initWithDelegate:(id<KSSensorDelegateProtocol>) delegate
{
    self = [super init];
    if(self) {
        _delegate = delegate;
    }
    
    return self;
}

- (BOOL)startRecordingEvents
{
    BOOL success = NO;
    if(self.isActive || // no need to start recording again
       (success = [self _registerForEvents]))
        [self setActive:YES];
    else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not register sensor '%@' for events!", self.name);
    }
    return success;
}


- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished
{
    if(self.isActive) { // no need to stop recording again
        [self _unregisterForEventsFinished:^(BOOL successful) {
            if(successful) {
                [self setActive:NO];
            } else {
                LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not unregister sensor '%@' for events!", self.name);
            }
            finished(successful);
        }];
    }
}


- (void)dealloc
{
    if(self.isActive)
        [self _unregisterForEventsFinished:nil];
}

@end


@implementation KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'registerForEvents'.");
    return NO;
}

- (void)_unregisterForEventsFinished:(void (^)(BOOL))finished
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'unregisterForEvents'.");
}

@end
