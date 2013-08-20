//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSGlobals.h"

@implementation KSFocusSensor

-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        self.sensorID = kKSSensorIDFocusSensor;
        self.name = kKSSensorNameFocusSensor;
    }
    return self;
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (void)_registerForEvents
{
    // TODO
    NSLog(@"TODO: focusSensor::registerForEvents");
}

- (void)_unregisterForEvents
{
    // TODO
    NSLog(@"TODO: focusSensor::unregisterForEvents");
}

@end