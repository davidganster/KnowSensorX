//
//  KSFocusEvent.h
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
