//
//  KSMenu.m
//  KnowSensor X
//
//  Created by David Ganster on 19/11/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSMenuController.h"
#import "KSProject+Addons.h"
#import "KSActivity+Addons.h"
#import "KSSensorController.h"
#import "KSUserInfo.h"
#import "KSAppDelegate.h"
#import "KSMainWindowController.h"


@interface KSMenuController ()

/// The menu item that shows the current project/activity.
/// Will be updated when `currentProject` or `currentActivity` are set.
@property (weak) IBOutlet NSMenuItem *currentActivityMenuItem;

/// Re-declaring the menu object as readwrite - we do want a setter internally.
@property (readwrite, strong) IBOutlet NSMenu *menu;

/// The menu item that manages the project list submenu.
@property (weak) IBOutlet NSMenuItem *projectListMenuItem;

@end

@implementation KSMenuController

- (id)init
{
    self = [super init];
    if(self) {
        NSArray *nibElements;
        NSNib *nib = [[NSNib alloc] initWithNibNamed:@"KSMenu" bundle:nil];
        BOOL couldLoadNib = [nib instantiateWithOwner:self topLevelObjects:&nibElements];
        if(couldLoadNib) {
            for (id item in nibElements) {
                if([item isKindOfClass:[NSMenu class]]) {
                    self.menu = item;
                    self.currentActivityMenuItem.title = @"No active project/activity.";
                    break;
                }
            }
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(serverUp:)
                                                         name:kKSNotificationKeyServerReachable
                                                       object:nil];

        } else {
            // no point in doing anything else if we could not even load the menu...
            return nil;
        }
    }
    return self;
}

- (void)serverUp:(NSNotification *)notification
{
    [[KSProjectController sharedProjectController] addObserverForProjectRelatedEvents:self];
    [[KSProjectController sharedProjectController] startUpdatingProjectListWithTimeBetweenPolls:kKSProjectControllerPollInterval];
}

- (void)projectController:(KSProjectController *)controller projectListChangedWithAddedProjects:(NSArray *)addedObjects
         deletedProjects:(NSArray *)deletedProjects
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Project list changed!");
    
    // We don't really need to keep track of the changes here, since we just replace the full project list.
    [self setProjectList:controller.currentProjectList];
}

-(void)projectController:(KSProjectController *)controller activeActivityChangedToActivity:(KSActivity *)activity
{
    [self setCurrentActivity:activity];
}

- (void)setCurrentActivity:(KSActivity *)currentActivity
{
    _currentActivity = currentActivity;
    [self updateCurrentProjectItem];
}

- (void)updateCurrentProjectItem
{
    NSString *newTitle = @"No active project/activity.";
    if(self.currentActivity) {
        newTitle = [self.currentActivity.projectName stringByAppendingString:[@"/" stringByAppendingString:self.currentActivity.name]];
    }
    self.currentActivityMenuItem.title = newTitle;
}

// projectList contains only valid object, no deleted ones.
- (void)setProjectList:(NSArray *)projectList
{
    if([self.projectList isEqualToArray:projectList])
        return;
    // we need to update our project menu.
    NSMenu *projectListSubmenu = [[NSMenu alloc] init];
    
    NSEnumerator *reverseEnumerator = [projectList reverseObjectEnumerator];
    KSProject *project = nil;
    while((project = [reverseEnumerator nextObject])) {
        // TODO: maybe use custom menu items here for convenience of getting the object later
        NSMenuItem *projectMenuItem = [[NSMenuItem alloc] initWithTitle:project.name
                                                                 action:nil
                                                          keyEquivalent:@""];
        if(project.name == self.currentActivity.projectName) {
            [projectMenuItem setEnabled:YES];
        }
        
        [projectListSubmenu insertItem:projectMenuItem atIndex:0];
    }
    
    [self.projectListMenuItem setSubmenu:projectListSubmenu];
}


- (IBAction)showPreferencePane:(id)sender
{
    [NSApp activateIgnoringOtherApps:YES];
    
    KSAppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    KSMainWindowController *controller = delegate.mainWindowController;
    
    [controller showWindow:controller.window];
}

- (IBAction)showWebApp:(id)sender
{
    NSURL *url = [NSURL URLWithString:[[KSUserInfo sharedUserInfo] serverAddress]];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)togglePrivateMode:(NSMenuItem *)sender
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

- (IBAction)writeToDiary:(id)sender
{
    NSString *baseUrl = [[KSUserInfo sharedUserInfo] serverAddress];
    NSString *fullUrl = [baseUrl stringByAppendingString:kKSServerShowObservationsURL];
    NSURL *url = [NSURL URLWithString:fullUrl];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)quit:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

@end
