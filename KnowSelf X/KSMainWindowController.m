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
    [self.statusItem setTitle:@"KSX"];
    [self.statusItem setMenu:self.statusBarMenu];
    [self.statusItem setHighlightMode:YES];
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
