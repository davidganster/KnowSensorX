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

@interface KSMainWindowController ()

/// The status item that is displayed in the MenuBar. Has to be retained, otherwise it will immediately be deallocated.
@property(nonatomic, strong) NSStatusItem *statusItem;

/// All projects will get a menu item with their title. Kept as a member for comparing changes.
@property(nonatomic, strong) NSMutableArray *projectMenuItems;

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
    [[KSProjectController sharedProjectController] startUpdatingProjectListWithTimeInterval:kKSProjectControllerPollInterval];
    
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

-(void)projectController:(KSProjectController *)controller projectListChangedWithAddedProjects:(NSArray *)addedObjects
         deletedProjects:(NSArray *)deletedProjects
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Project list changed!");
    [self updateProjectMenuWithAddedProjects:addedObjects deletedProjects:deletedProjects];
}

- (void)createMenubarItem
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setImage:[NSImage imageNamed:@"statusbar_icon"]];
    [self.statusItem setMenu:self.statusBarMenu];
    [self.statusItem setHighlightMode:YES];
}

- (void)updateProjectMenuWithAddedProjects:(NSArray *)addedProjects deletedProjects:(NSArray *)deletedProjects
{
    NSEnumerator *reverseEnumerator = [addedProjects objectEnumerator];
    KSProject *project = nil;
    while((project = [reverseEnumerator nextObject])) {
        // TODO: maybe use custom menu items here for convenience of getting the object later
        NSMenuItem *projectMenuItem = [[NSMenuItem alloc] initWithTitle:project.name
                                                                 action:@selector(projectClicked:)
                                                          keyEquivalent:@""];
        [projectMenuItem setTarget:self];
        
        [self.projectsMenu insertItem:projectMenuItem atIndex:0];
    }
}

- (void)projectClicked:(NSMenuItem *)projectMenuItem
{
    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Project clicked!");
}

- (IBAction)bringWindowToFront:(id)sender
{
    [NSApp activateIgnoringOtherApps:YES];
    [self showWindow:self];
}

- (IBAction)showWebAppButtonPressed:(id)sender
{
    NSURL *url = [NSURL URLWithString:[[KSUserInfo sharedUserInfo] serverAddress]];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)privateModeButtonPressed:(NSMenuItem *)sender
{
    if(sender.state == NSOffState) {
        [sender setState:NSOnState];
        [[KSSensorController sharedSensorController] stopRecordingEvents];
    } else if(sender.state == NSOnState) {
        [sender setState:NSOffState];
        [[KSSensorController sharedSensorController] startRecordingEvents];
    } else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"The privateMode button is in mixed state?!");
    }
}

- (IBAction)writeToDiaryButtonPressed:(id)sender
{
    NSString *baseUrl = [[KSUserInfo sharedUserInfo] serverAddress];
    NSString *fullUrl = [baseUrl stringByAppendingString:kKSServerShowObservationsURL];
    NSURL *url = [NSURL URLWithString:fullUrl];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)quitApplication:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
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
