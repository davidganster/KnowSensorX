//
//  KSRecordActivityWindowController.h
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

#import <Cocoa/Cocoa.h>
#import "KSProjectController.h"

/**
 * The KSRecordActivityWindowController is responsible for displaying a simple floating window that
 * lets the user record a new activity. Will also create a new project/activity if either does not exist.
 * Warns the user in case another activity is already recording (with an option to turn this warning off entirely).
 */
@interface KSRecordActivityWindowController : NSWindowController<NSComboBoxDataSource, NSComboBoxDelegate, KSProjectControllerEventObserver, NSAlertDelegate>

/**
 *  Designated initializer. Do not use another initializer to create a new instance.
 *  Also loads the appropriate nib file (KSRecordActivityWindowController.xib).
 *
 *  @param project  The project to set by default.
 *  @param activity The activity to set by default.
 *
 *  @return The newly created KSRecordActivityWindowController object.
 */
- (id)initWithProject:(KSProject *)project activity:(KSActivity *)activity;

@end
