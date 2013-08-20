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

- (void)startRecordingEvents
{
    if(self.isActive)
        [self _registerForEvents];
}


- (void)stopRecordingEvents
{
    [self _unregisterForEvents];
}

@end


@implementation KSSensor (SubclassingHooks)

- (void)_registerForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'registerForEvents'.");
}

- (void)_unregisterForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'unregisterForEvents'.");
}

@end
