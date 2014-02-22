//
//  KSEvent_InternalWithAdditionalMethods.h
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "KSExportable.h"

@interface KSEvent_InternalWithAdditionalMethods : KSExportable

/// This method is specific to the events and does not require an additional variable.
/// For example, the KSIdleSensor will always return 'Idle Sensor', while the KSFocusSensor will return its 'processName' field.
- (NSString *)application;

+ (NSString *)stringForType:(KSEventType)type;

@end
