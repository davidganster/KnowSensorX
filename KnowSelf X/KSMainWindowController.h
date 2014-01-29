//
//  KSMainWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSSensor.h"
#import "KSProjectController.h"

/**
 * @author David Ganster
 * @documentation this class manages the main window of the program. no logic being done here.
 */
@interface KSMainWindowController : NSWindowController<NSTabViewDelegate, KSProjectControllerEventObserver>

@property(nonatomic, strong) NSArray *tabViewControllers;

@property (weak) IBOutlet NSToolbarItem *settingsToolbarItem;
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSToolbar *toolbar;


- (IBAction)settingsButtonPressed:(id)sender;

@end
