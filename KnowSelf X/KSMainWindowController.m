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
#import "KSSensorViewController.h"
#import "KSSettingsViewController.h"


#import "KSProject+Addons.h"
#import "KSActivity+Addons.h"

#import "KSAPIClient.h"

@interface KSMainWindowController ()

@property(nonatomic, strong) NSStatusItem *statusItem;

@end

@implementation KSMainWindowController

- (void)awakeFromNib
{
    // init viewControllers
    KSSensorViewController *sensorViewController = [[KSSensorViewController alloc] init];
    KSSettingsViewController *settingsViewController = [[KSSettingsViewController alloc] init];
    
    self.tabViewControllers = @[sensorViewController, settingsViewController];
    
    NSTabViewItem *sensorTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSensorTabViewIdentifier];
    [sensorTabViewItem setView:sensorViewController.view];
    
    NSTabViewItem *settingsTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:kKSSettingsTabViewIdentifier];
    [settingsTabViewItem setView:settingsViewController.view];
    
    [self.tabView addTabViewItem:sensorTabViewItem];
    [self.tabView addTabViewItem:settingsTabViewItem];
        
    [self createMenubarItem];
    
    
//    NSString *exePath = [[NSBundle mainBundle] executablePath];
//    CFStringRef stringRef = (__bridge CFStringRef)exePath;
//    AXMakeProcessTrusted(stringRef);
//    if(!AXAPIEnabled()) {
//        NSLog(@"Access for assistive devices must be enabled for this application to work properly");
//    }
//    [self.tabView selectTabViewItemWithIdentifier:kKSSensorTabViewIdentifier];
}

- (void)createMenubarItem
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setTitle:@"KSX"]; // TODO: get icon from Stefan.
    [self.statusItem setMenu:self.statusBarMenu];
    [self.statusItem setHighlightMode:YES];
}

- (void)updateProjectMenuWithProjects:(NSArray *)projects
{
    [self.projectsMenu removeAllItems];
    for (KSProject *project in projects) {
        // TODO: maybe use custom menu items here for convenience of getting the object later
        NSMenuItem *projectMenuItem = [[NSMenuItem alloc] initWithTitle:project.name
                                                                 action:@selector(projectClicked:)
                                                          keyEquivalent:@""];
        [projectMenuItem setTarget:self];
        
        [self.projectsMenu addItem:projectMenuItem];
    }
}

- (void)projectClicked:(NSMenuItem *)projectMenuItem
{
    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Project clicked!");
}

- (IBAction)getProjectsMenuItemAction:(id)sender
{
    [[KSAPIClient sharedClient] loadProjectsWithSuccess:^(NSArray *projects) {
        [self updateProjectMenuWithProjects:projects];
        KSProject *project = projects[0];
        NSString *projectID = project.projectID;
        
        
        KSActivity *activity = [KSActivity createInContext:[NSManagedObjectContext defaultContext]];
        [activity setStartDate:[NSDate date]];
        [activity setProjectName:projectID];
        [activity setActivityID:@""];
        [activity setName:@"I'm programming right now!"];
        
        [[KSAPIClient sharedClient] startRecordingActivity:activity success:^(NSString *newActivityID) {
            NSLog(@"");
        } failure:^(NSError *error) {
            NSLog(@"");
        }];
        
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"Error when trying to get project list: %@", error);
    }];
}

- (IBAction)bringWindowToFront:(id)sender
{
    [NSApp activateIgnoringOtherApps:YES];
    [self showWindow:self];
}

- (IBAction)quitApplication:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.toolbar setSelectedItemIdentifier:@"Sensors"];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)sensorButtonPressed:(id)sender {
    [self.tabView selectTabViewItemWithIdentifier:kKSSensorTabViewIdentifier];
}

- (IBAction)settingsButtonPressed:(id)sender {
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

@end
