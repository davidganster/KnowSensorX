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
#define kKSURLPathIdleDidStart @"userIdleStart"
#define kKSURLPathIdleDidEnd @"userIdleEnd"

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



#endif
