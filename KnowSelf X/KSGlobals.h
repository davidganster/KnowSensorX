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

// Default base URL for server calls. Since it is customizable, this is only the fallback option, and can be configured in the settings (see KSUserInfo for more information)
#define kKSServerBaseURL @"http://127.0.0.1:8182"

/// URL scheme for the "write to diary" page in the web application.
#define kKSServerShowObservationsURL @"/?showobservations=1"

// Further URLs:
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

#define kKSProjectsTabViewIdentifier @"ProjectsTabView"
#define kKSSettingsTabViewIdentifier @"SettingsTabView"

#define kKSUserNameTextFieldIdentifier @"userNameTextField"
#define kKSDeviceNameTextFieldIdentifier @"deviceNameTextField"
#define kKSServerAddressTextFieldIdentifier @"serverAddressTextField"

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
// User Defaults Keys
//------------------------------------------------------------------------------
#define kKSUserInfoUserNameKey @"UserName"
#define kKSUserInfoDeviceNameKey @"DeviceName"
#define kKSUserInfoServerAddressKey @"ServerAddress"

#define kKSIsFirstStartKey @"firstStart"

//------------------------------------------------------------------------------
// General Constants
//------------------------------------------------------------------------------

/// If (and only if) this is UNdefined, recorded events will be saved to the persistent store.
/// Comment out if you want events to be saved.
#define kKSIsSaveToPersistentStoreDisabled

/// Minimum idle time before an event is registered in seconds. Defaults to 600 (10 minutes)
#define kKSIdleSensorMinimumIdleTime 600

/// Interval in seconds between two polls for the focus sensor.
#define kKSFocusSensorPollInterval 1.0f

// constants for communicating with the server
#define kKSKnowServerRelativeBasePath [[[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent] stringByAppendingString:@"/KnowSelf/KnowServer/"]
#define kKSKnowServerRelativePaxRunnerPath [kKSKnowServerRelativeBasePath stringByAppendingString:@"pax-run.sh"]
#define kKSKnowServerRelativePaxRunnerArgs @[[NSString stringWithFormat:@"--args=file:%@mac.runner.args", kKSKnowServerRelativeBasePath], \
                                     [NSString stringWithFormat:@"%@bundles/", kKSKnowServerRelativeBasePath]]

#define kKSKnowServerPaxRunnerPathOLD @"/Library/Services/KnowSelf/KnowServer/pax-run.sh"
#define kKSKnowServerPaxRunnerArgsOLD @[@"--args=file:/Library/Services/KnowSelf/KnowServer/mac.runner.args", @"/Library/Services/KnowSelf/KnowServer/bundles"]

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
#define kKSLogTagSensorController @"Sensor Controller"
#define kKSLogTagOther @"Unspecified"

#endif
