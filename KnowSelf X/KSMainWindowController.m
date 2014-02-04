//
//  KSMainWindowController.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSMainWindowController.h"
#import "KSEvent.h"
#import "KSFocusEvent+Addons.h"
#import "KSFocusSensor.h"
#import "KSIdleSensor.h"
#import "KSSettingsViewController.h"
#import "KSSpecialApplicationsViewController.h"
#import "KSSensorController.h"

#import "KSProject+Addons.h"
#import "KSActivity+Addons.h"
#import "KSUserInfo.h"
#import "KSAPIClient.h"
#import "KSProjectController.h"
#import "KSMenuController.h"

@interface KSMainWindowController ()

/// The status item that is displayed in the MenuBar. Has to be retained, otherwise it will immediately be deallocated.
@property(nonatomic, strong) NSStatusItem *statusItem;

/// All projects will get a menu item with their title. Kept as a member for comparing changes.
@property(nonatomic, strong) NSMutableArray *projectMenuItems;

/// The menu controller that handles the menu when the status item is clicked.
@property(nonatomic, strong) KSMenuController *menuController;

@end

@implementation KSMainWindowController

- (void)awakeFromNib
{
    // init viewControllers
    KSSettingsViewController *settingsViewController = [[KSSettingsViewController alloc] init];
    KSSpecialApplicationsViewController *specialApplicationsViewController = [[KSSpecialApplicationsViewController alloc] init];
    
    self.tabViewControllers = @[specialApplicationsViewController, settingsViewController];
    
    NSTabViewItem *specialApplicationsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSpecialApplicationsTabViewIdentifier];
    [specialApplicationsTabViewItem setView:specialApplicationsViewController.view];
    
    NSTabViewItem *settingsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSettingsTabViewIdentifier];
    [settingsTabViewItem setView:settingsViewController.view];
    
    [self.tabView addTabViewItem:specialApplicationsTabViewItem];
    [self.tabView addTabViewItem:settingsTabViewItem];
    
    [self createMenubarItem];
    
    // TODO: move this to some callback for when the server is up. (said callback doesn't exist yet)
    [[KSSensorController sharedSensorController] startRecordingEvents];
    
//    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
    [self settingsButtonPressed:nil];
}

- (void)createMenubarItem
{
    self.menuController = [[KSMenuController alloc] init];
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setImage:[NSImage imageNamed:@"statusbar_icon"]];
    [self.statusItem setMenu:self.menuController.menu];
    [self.statusItem setHighlightMode:YES];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.toolbar setSelectedItemIdentifier:@"Settings"];
}

- (IBAction)specialApplicationsButtonPressed:(id)sender
{
    NSRect frame = [self.window frame];
    frame.size.width = 480.f;
    CGFloat toolbarHeight = self.window.frame.size.height - [self.window.contentView bounds].size.height;
    frame.size.height = 272.f + toolbarHeight;
    frame.origin.y += self.window.frame.size.height;
    frame.origin.y -= 272.f+toolbarHeight;
    [self.window setFrame:frame display:YES animate:YES];
    [self.tabView selectTabViewItemWithIdentifier:kKSSpecialApplicationsTabViewIdentifier];
}

- (IBAction)settingsButtonPressed:(id)sender
{
    NSRect frame = [self.window frame];
//    NSRect newViewFrame = [[self.tabViewControllers[1] view] bounds];
    frame.size.width = 400.f;
    CGFloat toolbarHeight = self.window.frame.size.height - [self.window.contentView bounds].size.height;
    frame.size.height = 157.f + toolbarHeight;
//    frame.size.height = newViewFrame.size.height + toolbarHeight;
    frame.origin.y += self.window.frame.size.height;
    frame.origin.y -= 157.f + toolbarHeight;
    [self.window setFrame:frame display:YES animate:YES];
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

@end
