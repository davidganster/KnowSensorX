//
//  KSMainWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSSensor.h"

/**
 * @author David Ganster
 * @documentation this class manages the main window of the program. no logic being done here.
 */
@interface KSMainWindowController : NSWindowController<NSTabViewDelegate>

@property(nonatomic, strong) NSArray *tabViewControllers;

@property (weak) IBOutlet NSToolbarItem *sensorToolbarItem;
@property (weak) IBOutlet NSToolbarItem *settingsToolbarItem;
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSToolbar *toolbar;
@property (strong) IBOutlet NSMenu *statusBarMenu;
@property (weak) IBOutlet NSMenu *projectsMenu;

- (IBAction)sensorButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;
- (IBAction)getProjectsMenuItemAction:(id)sender;
- (IBAction)bringWindowToFront:(id)sender;

@end
