//
//  KSIdleSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSIdleSensor.h"
#import "KSGlobals.h"

@implementation KSIdleSensor

-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        self.sensorID = kKSSensorIDIdleSensor;
        self.name = kKSSensorNameIdleSensor;
    }
    return self;
}

@end

@implementation KSSensor (SubclassingHooks)

- (void)_registerForEvents
{
    // TODO
    NSLog(@"TODO: idleSensor::registerForEvents");
}

- (void)_unregisterForEvents
{
    // TODO
    NSLog(@"TODO: idleSensor::unregisterForEvents");
}

@end