//
//  KSSensorController.h
//  KnowSensor X
//
//  Created by David Ganster on 30/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSSensor.h"

/// Singleton class that manages all KSSensor objects, server interactions and event buffers.
@interface KSSensorController : NSObject<KSSensorDelegateProtocol>

/// Array of sensors currently held by the KSSensorController.
@property(nonatomic, strong, readonly) NSArray *sensors;

/// Accessor to the singleton object.
+ (KSSensorController *)sharedSensorController;

- (BOOL)startRecordingEvents;
- (BOOL)stopRecordingEvents;

@end