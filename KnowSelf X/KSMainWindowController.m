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

@interface KSMainWindowController ()

@property(nonatomic, strong) NSStatusItem *statusItem;

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
    
//    NSString *exePath = [[NSBundle mainBundle] executablePath];
//    CFStringRef stringRef = (__bridge CFStringRef)exePath;
//    AXMakeProcessTrusted(stringRef);
//    if(!AXAPIEnabled()) {
//        NSLog(@"Access for assistive devices must be enabled for this application to work properly");
//    }
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

- (void)createMenubarItem
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setImage:[NSImage imageNamed:@"statusbar_icon"]];
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
//        KSProject *project = projects[0];
//        NSString *projectID = project.projectID;
//        
//        
//        KSActivity *activity = [KSActivity createInContext:[NSManagedObjectContext defaultContext]];
//        [activity setStartDate:[NSDate date]];
//        [activity setProjectName:projectID];
//        [activity setActivityID:@""];
//        [activity setName:@"I'm programming right now!"];
//        
//        [[KSAPIClient sharedClient] startRecordingActivity:activity success:^(NSString *newActivityID) {
//            NSLog(@"");
//        } failure:^(NSError *error) {
//            NSLog(@"");
//        }];
    } failure:^(NSError *error) {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"Error when trying to get project list: %@", error);
    }];
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
