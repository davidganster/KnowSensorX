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
#import "KSURLMappingViewController.h"

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
    KSURLMappingViewController *urlMappingsViewController = [[KSURLMappingViewController alloc] init];
    
    self.tabViewControllers = @[specialApplicationsViewController, settingsViewController, urlMappingsViewController];
    
    NSTabViewItem *specialApplicationsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSpecialApplicationsTabViewIdentifier];
    [specialApplicationsTabViewItem setView:specialApplicationsViewController.view];
    
    NSTabViewItem *settingsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSettingsTabViewIdentifier];
    [settingsTabViewItem setView:settingsViewController.view];
    
    NSTabViewItem *urlMappingsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSURLMappingsTabViewIdentifier];
    [urlMappingsTabViewItem setView:urlMappingsViewController.view];
    
    [self.tabView addTabViewItem:specialApplicationsTabViewItem];
    [self.tabView addTabViewItem:settingsTabViewItem];
    [self.tabView addTabViewItem:urlMappingsTabViewItem];
    
    [self createMenubarItem];
    
    // TODO: move this to some callback for when the server is up. (said callback doesn't exist yet)
    [[KSSensorController sharedSensorController] startRecordingEvents];
    
    [self.toolbar setSelectedItemIdentifier:@"Settings"];
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

- (IBAction)specialApplicationsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(480.f, 272.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSSpecialApplicationsTabViewIdentifier];
}

- (IBAction)settingsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(400.f, 195.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

- (IBAction)URLMappingsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(480.f, 314.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSURLMappingsTabViewIdentifier];
}

#pragma mark - Helper
- (void)resizeWindowToSize:(CGSize)size
{
    NSRect frame = [self.window frame];
    //    NSRect newViewFrame = [[self.tabViewControllers[1] view] bounds];
    frame.size.width = size.width;
    CGFloat toolbarHeight = self.window.frame.size.height - [self.window.contentView bounds].size.height;
    frame.size.height = size.height + toolbarHeight;
    //    frame.size.height = newViewFrame.size.height + toolbarHeight;
    frame.origin.y += self.window.frame.size.height;
    frame.origin.y -= size.height + toolbarHeight;
    [self.window setFrame:frame display:YES animate:YES];
}

@end
