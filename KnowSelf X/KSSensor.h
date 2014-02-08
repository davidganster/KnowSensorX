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

@interface KSSensor : NSObject {
    @protected
    NSString *_sensorID;
    NSString *_name;
}

@property(nonatomic, weak) id<KSSensorDelegateProtocol> delegate;
@property(nonatomic, assign, setter = setActive:) BOOL isActive;

/// used for API calls
@property(nonatomic, strong, readonly) NSString *sensorID;

/// used for display names
@property(nonatomic, strong, readonly) NSString *name;

// public API, not meant for subclassing:
- (id)initWithDelegate:(id<KSSensorDelegateProtocol>) delegate;
- (BOOL)startRecordingEvents;
- (BOOL)stopRecordingEvents;

@end

/**
 * The methods included in this category are meant to be overridden in subclases, and for internal use only - they should not be called from outside.
 */
@interface KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents;
- (BOOL)_unregisterForEvents;

@end
