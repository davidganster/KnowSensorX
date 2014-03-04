//
//  KSFocusSensor.h
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

#import "KSSensor.h"

@class KSFocusSensor;

/**
 *  Simple protocol for decoupling application-specific behaviour from the focus sensor, 
 *  such as URL mappings and whether or not to record specific applications.
 */
@protocol KSFocusSensorDelegate <NSObject>
@optional

/**
 *  Asks the focusDelegate for an alternative representation of the given URL,
 *  which will be used in the recorded event. 
 *  This makes for a nicer representation in the Web Application.
 *  If this method is not implemented or nil is returned, 
 *  the given URL will be used to represent the homepage.
 *
 *  @param sensor The KSFocusSensor object that recorded the URL.
 *  @param URL    The URL that has been returned from the active browser.
 *  @return       The alternative representation of the given URL.
 */
- (NSString *)focusSensor:(KSFocusSensor *)sensor mappedNameForURL:(NSString *)URL;

/**
 *  Asks the focusDelegate whether or not a specific application should be recorded.
 *  This method is invoked for every application on both getting and losing focus.
 *  If this method is not implemented, the sensor will assume 'YES'.
 *  @note This method will be called on a background thread.
 *
 *  @param sensor      The KSFocusSensor object that recorded the application.
 *  @param application The application in question.
 *  @return            YES if the sensor should create a KSFocusEvent and invoke the sensor:didRecordEvent: method on its delegate.
 */
- (BOOL)focusSensor:(KSFocusSensor *)sensor shouldRecordApplication:(NSRunningApplication *)application;

/**
 *  Asks the focusDelegate whether or not screenshots should be recorded for the given application.
 *  This method is invoked when an application gets focus - and possibly when it loses focus as well,
 *  should the first attempt to grab a screenshot have failed.
 *
 *  @param sensor       The KSFocusSensor object that wants to take screenshots.
 *  @param application  The application in question.
 *  @return             YES if the sensor should record a screenshot for this application.
 */
- (KSScreenshotQuality)focusSensor:(KSFocusSensor *)sensor
   screenshotQualityForApplication:(NSRunningApplication *)application;


@end

/** 
 *  This class catches and handles all "focus-change" events.
 *  It generates events when an application gets and loses the focus, and hands it to its delegate.
 *  Events are generated when the timer fires, and this class does not subscribe to any
 *  `NSWorkspace` notifications, because the timer would be needed anyway to detect tab- or window
 *  switches within a single application.
 */
@interface KSFocusSensor : KSSensor

/// Optional delegate for KSFocusSensor-specific delegate method. See KSFocusSensorDelegate for more information.
@property(nonatomic, strong) id<KSFocusSensorDelegate> focusDelegate;

@end
