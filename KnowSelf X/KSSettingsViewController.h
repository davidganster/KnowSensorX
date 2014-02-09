//
//  KSSettingsViewController.h
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KSSettingsViewController : NSViewController<NSTextFieldDelegate>

@property (weak) IBOutlet NSView *hackToFixIB;
@property (weak) IBOutlet NSTextField *userNameTextField;
@property (weak) IBOutlet NSTextField *serverAddressTextField;
@property (weak) IBOutlet NSTextField *deviceNameTextField;

@end
