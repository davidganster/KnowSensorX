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
#import "KSProjectsViewController.h"
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
    KSProjectsViewController *projectsViewController = [[KSProjectsViewController alloc] init];
    
    self.tabViewControllers = @[projectsViewController, settingsViewController];
    
    NSTabViewItem *projectsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSProjectsTabViewIdentifier];
    [projectsTabViewItem setView:projectsViewController.view];
    
    NSTabViewItem *settingsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSettingsTabViewIdentifier];
    [settingsTabViewItem setView:settingsViewController.view];
    
    [self.tabView addTabViewItem:projectsTabViewItem];
    [self.tabView addTabViewItem:settingsTabViewItem];
    
    [self createMenubarItem];
    
    
    // TODO: move this to some callback for when the server is up. (said callback doesn't exist yet)
    [[KSSensorController sharedSensorController] startRecordingEvents];
    
    [[KSProjectController sharedProjectController] addObserverForProjectRelatedEvents:self];
    [[KSProjectController sharedProjectController] startUpdatingProjectListWithTimeBetweenPolls:kKSProjectControllerPollInterval];
    
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

-(void)projectController:(KSProjectController *)controller projectListChangedWithAddedProjects:(NSArray *)addedObjects
                        deletedProjects:(NSArray *)deletedProjects
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Project list changed!");
    
    // We don't really need to keep track of the changes here, since we just replace the full project list.
    [self.menuController setProjectList:controller.currentProjectList];
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

- (IBAction)projectsButtonPressed:(id)sender {
//    [self.window setFrame:NSRectFromCGRect(CGRectMake(self.window.frame.origin.x,
//                                                      self.window.frame.origin.y,
//                                                      338,
//                                                      504))
//                  display:YES
//                  animate:YES];
    [self.tabView selectTabViewItemWithIdentifier:kKSProjectsTabViewIdentifier];
}

- (IBAction)settingsButtonPressed:(id)sender {
//    [self.window setFrame:NSRectFromCGRect(CGRectMake(self.window.frame.origin.x,
//                                                      self.window.frame.origin.y,
//                                                      338,
//                                                      500))
//                  display:YES
//                  animate:YES];
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

@end
