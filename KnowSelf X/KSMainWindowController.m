//
//  KSMainWindowController.m
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "KSMainWindowController.h"
#import "KSEvent.h"
#import "KSFocusEvent.h"
#import "KSFocusSensor.h"
#import "KSIdleSensor.h"
#import "KSSettingsViewController.h"
#import "KSSpecialApplicationsViewController.h"
#import "KSSensorController.h"

#import "KSProject.h"
#import "KSActivity.h"
#import "KSUserInfo.h"
#import "KSAPIClient.h"
#import "KSProjectController.h"
#import "KSMenuController.h"
#import "KSURLMappingViewController.h"

@interface KSMainWindowController ()

@property (weak) IBOutlet NSToolbarItem *settingsToolbarItem;
@property (weak) IBOutlet NSToolbarItem *specialApplicationsToolbarItem;
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSToolbar *toolbar;

/// All the view controllers need to be retained somewhere, so we just put them in an array.
@property(nonatomic, strong) NSArray *tabViewControllers;

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
    [self.window setLevel:NSFloatingWindowLevel];
}

- (IBAction)specialApplicationsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(480.f, 272.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSSpecialApplicationsTabViewIdentifier];
}

- (IBAction)settingsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(448.f, 367.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSSettingsTabViewIdentifier];
}

- (IBAction)URLMappingsButtonPressed:(id)sender
{
    [self resizeWindowToSize:CGSizeMake(480.f, 314.f)];
    [self.tabView selectTabViewItemWithIdentifier:kKSURLMappingsTabViewIdentifier];
}

#pragma mark - Helper
/**
 *  Helper method that creates the KSMenuController and adds the status item to the status bar.
 */
- (void)createMenubarItem
{
    self.menuController = [[KSMenuController alloc] init];
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setImage:[NSImage imageNamed:@"statusbar_icon"]];
    [self.statusItem setMenu:self.menuController.menu];
    [self.statusItem setHighlightMode:YES];
}

/**
 *  Helper method that resizes the window to the given size with a smooth animation, 
 *  accounting for the y-offset and toolbar size.
 *
 *  @param size The new size for the window (without toolbar height).
 */
- (void)resizeWindowToSize:(CGSize)size
{
    NSRect frame = [self.window frame];
    frame.size.width = size.width;
    CGFloat toolbarHeight = self.window.frame.size.height - [self.window.contentView bounds].size.height;
    frame.size.height = size.height + toolbarHeight;
    frame.origin.y += self.window.frame.size.height;
    frame.origin.y -= size.height + toolbarHeight;
    [self.window setFrame:frame display:YES animate:YES];
}

@end
