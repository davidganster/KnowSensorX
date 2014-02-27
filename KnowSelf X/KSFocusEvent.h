//
//  KSFocusEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"

@class KSScreenshotData;

/**
 *  Describes a focus event to be sent to the server.
 *  Mirrors the data model on the KnowServer.
 */
@interface KSFocusEvent : KSEvent

/// Path to the currently open file or URL of the frontmost application.
/// Might be nil if the application doesn't have a file open or doesn't
/// comply to Apple's guidlines for AppleScript interfaces.
@property (nonatomic, retain) NSString * filePath;
/// Process ID of the frontmost application.
@property (nonatomic, retain) NSString * processID;
/// Process name of the frontmost application.
@property (nonatomic, retain) NSString * processName;
/// Unused member, but needs to be included in the JSON sent to the server.
/// Always set to the empty string.
@property (nonatomic, retain) NSString * runtimeID;
/// Unused member, but needs to be included in the JSON sent to the server.
/// Always set to the empty string.
@property (nonatomic, retain) NSString * windowhandle;
/// Title of the frontmost window of the frontmost application.
/// Might be nil if the window doesn't have a title or the application it belongs to
/// doesn't compy to Apple's guidelines for AppleScript interfaces.
@property (nonatomic, retain) NSString * windowTitle;
/// The screenshot of the frontmost window, already scaled down to the chosen factor.
/// Will be nil if screenshots are disabled (see KSUserInfo `shouldRecordScreenshots` for more info).
@property (nonatomic, retain) KSScreenshotData *screenshot;

@end
