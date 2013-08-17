//
//  KSMainWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSSensor.h"

@interface KSMainWindowController : NSWindowController<KSSensorDelegateProtocol>

@property (weak) IBOutlet NSToolbarItem *sensorToolbarItem;
@property (weak) IBOutlet NSToolbarItem *settingsToolbarItem;

@end
