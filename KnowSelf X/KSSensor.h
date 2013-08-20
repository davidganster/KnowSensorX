//
//  KSSensor.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>


@class KSSensor;
@class KSEvent;

@protocol KSSensorDelegateProtocol <NSObject>

- (void)sensor:(KSSensor *) sensor didRecordEvent:(KSEvent *)event;

@end

@interface KSSensor : NSObject

@property(nonatomic, weak) id<KSSensorDelegateProtocol> delegate;
@property(nonatomic, assign, setter = setActive:) BOOL isActive;
//@property(nonatomic, assign, setter = setStoppable:) BOOL isStoppable;

/// used for API calls
@property(nonatomic, strong) NSString *sensorID;
/// used for display names
@property(nonatomic, strong) NSString *name;

// public API, not meant for subclassing:
- (id)initWithDelegate:(id<KSSensorDelegateProtocol>) delegate;
- (void)startRecordingEvents;
- (void)stopRecordingEvents;


@end


// these methods are meant for internal use only, and should not be called from outside.
@interface KSSensor (SubclassingHooks)

- (void)_registerForEvents;
- (void)_unregisterForEvents;

@end
