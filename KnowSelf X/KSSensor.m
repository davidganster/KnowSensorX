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
    if((success = [self _registerForEvents]))
      [self setActive:YES];
    else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not register sensor '%@' for events!", self.name);
    }
    return success;
}


- (BOOL)stopRecordingEvents
{
    BOOL success = NO;
    if((success = [self _unregisterForEvents]))
        [self setActive:NO];
    else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not unregister sensor '%@' for events!", self.name);
    }
    
    return success;
}


- (void)dealloc
{
    if(self.isActive)
       [self _unregisterForEvents];
}

@end


@implementation KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'registerForEvents'.");
    return NO;
}

- (BOOL)_unregisterForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'unregisterForEvents'.");
    return NO;
}

@end
