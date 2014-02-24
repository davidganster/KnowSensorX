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
/// Path to be used for applicationDidLoseFocus events.
#define kKSURLPathApplicationDidLoseFocusPath @"events/applicationDidLoseFocus"
/// Path to be used for applicationDidGetFocus events.
#define kKSURLPathApplicationDidGetFocusPath @"events/applicationDidGetFocus"
/// Path to be used for userIdleStart events.
#define kKSURLPathIdleDidStart @"events/userIdleStart"
/// Path to be used for userIdleEnd events.
#define kKSURLPathIdleDidEnd @"events/userIdleEnd"

// IDs for api-calls
/// Sensor ID for the Focus Sensor, important for the relevant API calls.
#define kKSSensorIDFocusSensor @"FocusSensor"
/// Sensor ID for the Idle Sensor, important for the relevant API calls.
#define kKSSensorIDIdleSensor @"IdleSensor"

/// applicationDidGetFocus-event type as string (used in API calls and for printing debug information)
#define kKSEventTypeDidGetFocus @"applicationDidGetFocus"
/// applicationDidLoseFocus-event type as string (used in API calls and for printing debug information)
#define kKSEventTypeDidLoseFocus @"applicationDidLoseFocus"
/// userIdleStart-event type as string (used in API calls and for printing debug information)
#define kKSEventTypeDidStartIdle @"userIdleStart"
/// userIdleEnd-event type as string (used in API calls and for printing debug information)
#define kKSEventTypeDidEndIdle @"userIdleEnd"

// JSON-dict keys
/// Key for the event-JSON sent to the server. Maps to which application was recorded.
#define kKSJSONKeyApplication @"application"
/// Key for the event-JSON sent to the server. Maps to sensor-specific data.
#define kKSJSONKeyData @"data"
/// Key for the event-JSON sent to the server. Maps to the device ID.
#define kKSJSONKeyDeviceID @"deviceid"
/// Key for the event-JSON sent to the server. Maps to the event type.
#define kKSJSONKeyType @"type"
/// Key for the event-JSON sent to the server. Maps to the timestamp.
#define kKSJSONKeyTimeStamp @"timestamp"
/// Key for the event-JSON sent to the server. Maps to the ID of the sensor that generated the event.
#define kKSJSONKeySensorID @"sensorid"
/// Key for the event-JSON sent to the server. Maps to the user's ID.
#define kKSJSONKeyUserID @"userid"

//------------------------------------------------------------------------------
// UI
//------------------------------------------------------------------------------
// strings for displaying the sensors name
#define kKSSensorNameFocusSensor @"Focus Sensor"
#define kKSSensorNameIdleSensor @"Idle Sensor"

#define kKSSpecialApplicationsTabViewIdentifier @"SpecialApplicationsTabView"
#define kKSSettingsTabViewIdentifier @"SettingsTabView"
#define kKSURLMappingsTabViewIdentifier @"URLMappingsTabView"


#define kKSUserNameTextFieldIdentifier @"userNameTextField"
#define kKSDeviceNameTextFieldIdentifier @"deviceNameTextField"
#define kKSServerAddressTextFieldIdentifier @"serverAddressTextField"

//------------------------------------------------------------------------------
// Enum Constants
//------------------------------------------------------------------------------

/// Used for switch-statements on the type property of a KSEvent object.
typedef enum KSEventTypeEnum {
    KSEventTypeDidGetFocus,     // Type for a 'did get focus' event.
    KSEventTypeDidLoseFocus,    // Type for a 'did lose focus' event.
    KSEventTypeIdleStart,       // Type for a 'idle start' event.
    KSEventTypeIdleEnd          // Type for a 'idle end' event.
} KSEventType;

/// Used to select an appropriate screenshot quality.
typedef enum KSScreenshotQuality {
    KSScreenshotQualitySmall    = 0,    // Favor small file size over image quality.
    KSScreenshotQualityMedium   = 1,    // Happy medium between file size and image quality.
    KSScreenshotQualityOriginal = 2,    // Full image, resulting in great quality but large file size.
    KSScreenshotQualityNone     = 0xFF  // No screenshot.
} KSScreenshotQuality;

//------------------------------------------------------------------------------
// Notification Keys
//------------------------------------------------------------------------------
#define kKSNotificationKeyUserIdleStart @"UserIdleStart"
#define kKSNotificationKeyUserIdleEnd  @"UserIdleEnd"
#define kKSNotificationKeyIdleTimeChanged @"IdleTimeChanged"
#define kKSNotificationUserInfoDidImport @"UserInfoDidImport"

#define kKSNotificationUserInfoKeyNewIdleTime @"NewIdleTime"

#define kKSNotificationKeyServerReachable @"ServerReachable"
#define kKSNotificationKeyServerUnreachable @"ServerUnreachable"

//------------------------------------------------------------------------------
// User Defaults Keys
//------------------------------------------------------------------------------
#define kKSUserInfoUserNameKey @"UserName"
#define kKSUserInfoDeviceNameKey @"DeviceName"
#define kKSUserInfoServerAddressKey @"ServerAddress"
#define kKSUserInfoSpecialApplicationsKey @"SpecialApplications"
#define kKSUserInfoSpecialApplicationsAreBlacklistKey @"isBlacklist"
#define kKSUserInfoURLMappingsKey @"URLMappings"
#define kKSUserInfoMinimumIdleTimeKey @"MinimumIdleTime"
#define kKSUserInfoShouldRecordScreenshotsKey @"shouldRecordScreenshots"
#define kKSUserInfoScreenshotQualityKey @"screenshotQuality"

#define kKSIsFirstStartKey @"firstStart"
#define kKSHasWarnedIfAlreadyRecordingActivityShouldBeStopped @"alreadyRecordingActivityWarning"

//------------------------------------------------------------------------------
// General Constants
//------------------------------------------------------------------------------

/// Minimum idle time before an event is registered in seconds. Defaults to 600 (10 minutes)
#define kKSIdleSensorMinimumIdleTime 240

/// The time in seconds between two polls when the user is idle.
/// This is a workaround for the keyboard/mouse events sometimes not being registered by a NSEventMonitor
/// when the user ends idle.
#define kKSIdleSensorRegisterIdleEndPollInterval 10.f

/// Interval in seconds between two polls for the focus sensor.
#define kKSFocusSensorPollInterval 1.5f

/// Workaround for the some processes that should never get the focus
#define kKSFocusSensorBlockedApplicationNames @[@"loginwindow", @"usernotificationcenter", @"securityagent"]

/// Interval in seconds between two polls for the project/activity list.
#define kKSProjectControllerPollInterval 3.0f

/// Interval in seconds between two polls when the server is up - it's less likely that the server will go down all of a sudden, so it's ok to check less often.
#define kKSAPIClientServerReachabilityPollIntervalServerUp 10.0f

/// Interval in seconds between two polls when the server is down - it's more likely that the server has just encountered an error and will recover soon (or just isn't up yet)
#define kKSAPIClientServerReachabilityPollIntervalServerDown 1.0f

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
#define kKSLogTagUI @"User Interface"
#define kKSLogTagSensorController @"Sensor Controller"
#define kKSLogTagProjectController @"Project Controller"
#define kKSLogTagScreenshotGrabber @"Screenshot Grabber"
#define kKSLogTagOther @"Other"

#endif
