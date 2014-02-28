//
//  KSRecordActivityWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 28/12/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

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
