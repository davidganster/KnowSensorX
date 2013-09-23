//
//  KSGlobals.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#ifndef KnowSensor_X_KSGlobals_h
#define KnowSensor_X_KSGlobals_h

//------------------------------------------------------------------------------
// API Calls
//------------------------------------------------------------------------------

// base url is a defined string for now (should be customizable by the user)
#define kKSServerBaseURL @"http://127.0.0.1:8182"

// URLs
#define kKSURLPathApplicationDidLoseFocusPath @"events/applicationDidLoseFocus"
#define kKSURLPathApplicationDidGetFocusPath @"events/applicationDidGetFocus"
#define kKSURLPathIdleDidStart @"events/userIdleStart"
#define kKSURLPathIdleDidEnd @"events/userIdleEnd"

// IDs for api-calls
#define kKSSensorIDFocusSensor @"FocusSensor"
#define kKSSensorIDIdleSensor @"IdleSensor"

#define kKSEventTypeDidGetFocus @"applicationDidGetFocus"
#define kKSEventTypeDidLoseFocus @"applicationDidLoseFocus"
#define kKSEventTypeDidStartIdle @"userIdleStart"
#define kKSEventTypeDidEndIdle @"userIdleEnd"

// JSON-dict keys
#define kKSJSONKeyApplication @"application"
#define kKSJSONKeyData @"data"
#define kKSJSONKeyDeviceID @"deviceid"
#define kKSJSONKeyType @"type"
#define kKSJSONKeyTimeStamp @"timestamp"
#define kKSJSONKeySensorID @"sensorid"
#define kKSJSONKeyUserID @"userid"

//------------------------------------------------------------------------------
// UI
//------------------------------------------------------------------------------

// strings for displaying the sensors name
#define kKSSensorNameFocusSensor @"Focus Sensor"
#define kKSSensorNameIdleSensor @"Idle Sensor"

#define kKSSensorTabViewIdentifier @"SensorTabView"
#define kKSSettingsTabViewIdentifier @"SettingsTabView"

//------------------------------------------------------------------------------
// Enum Constants
//------------------------------------------------------------------------------
/// used for switch-statements on the type property of a KSEvent object.
typedef enum KSEventTypeEnum {
    KSEventTypeDidGetFocus,
    KSEventTypeDidLoseFocus,
    KSEventTypeIdleStart,
    KSEventTypeIdleEnd
} KSEventType;


//------------------------------------------------------------------------------
// General Constants
//------------------------------------------------------------------------------

/// Minimum idle time before an event is registered in seconds. Defaults to 300.
#define kKSIdleSensorMinimumIdleTime 5

/// Interval in seconds between two polls for the focus sensor.
#define kKSFocusSensorPollInterval 1.0f

// constants for communicating with the server
#define kKSKnowServerPaxRunnerPath @"/Library/Services/KnowSelf/KnowServer/pax-run.sh"
#define kKSKnowServerPaxRunnerArgs @[@"--args=file:/Library/Services/KnowSelf/KnowServer/mac.runner.args", @"/Library/Services/KnowSelf/KnowServer/bundles"]
#define kKSKnowServerCommandCloseServer @"close\n"

//------------------------------------------------------------------------------
// Logging Levels
//------------------------------------------------------------------------------
#define kKSLogLevelError 0
#define kKSLogLevelDebug 1
#define kKSLogLevelInfo 2

#define kKSLogTagFocusSensor @"Focus Sensor"
#define kKSLogTagIdleSensor @"Idle Sensor"
#define kKSLogTagAPIClient @"API Client"
#define kKSLogTagOther @"Unspecified"

#endif
