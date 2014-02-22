//
//  KSMenu.m
//  KnowSensor X
//
//  Created by David Ganster on 19/11/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSMenuController.h"
#import "KSProject.h"
#import "KSActivity.h"
#import "KSSensorController.h"
#import "KSUserInfo.h"
#import "KSAppDelegate.h"
#import "KSMainWindowController.h"
#import "KSRecordActivityWindowController.h"


@interface KSMenuController ()

/// The menu item that shows the current project/activity.
/// Will be updated when `currentProject` or `currentActivity` are set.
@property (weak) IBOutlet NSMenuItem *currentActivityMenuItem;

/// The menu item that can stop the currently recording activity.
/// Needs an outlet because its enabled/disabled state will change during runtime.
/// @note Since setting enabled/disabled on an NSMenuItem
@property (weak) IBOutlet NSMenuItem *stopRecordingActivityMenuItem;

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
                    self.currentActivity = nil;
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

- (void)projectController:(KSProjectController *)controller activeActivityChangedToActivity:(KSActivity *)activity
{
    [self setCurrentActivity:activity];
}

- (void)setCurrentActivity:(KSActivity *)currentActivity
{
    _currentActivity = currentActivity;
    
    [self.stopRecordingActivityMenuItem setAction:(_currentActivity ) ? @selector(stopRecordingActiveActivity:) : nil];
    [self.menu update];
    
    // set the current project in the project list ton have the tick
    for (NSMenuItem *menuItem in self.projectListMenuItem.submenu.itemArray) {
        KSProject *project = [menuItem representedObject];
        if(project == _currentActivity.project && project != nil) {
            [menuItem setState:NSOnState];
        } else {
            [menuItem setState:NSOffState];
        }
    }
    
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

// projectList contains only valid objects, no deleted ones.
- (void)setProjectList:(NSArray *)projectList
{
    if([self.projectList isEqualToArray:projectList])
        return;
    
    if(!self.projectList && projectList) {
        // first time with data
        self.projectListMenuItem.submenu = [[NSMenu alloc] init];
    }
    
    NSEnumerator *reverseEnumerator = [projectList reverseObjectEnumerator];
    KSProject *project = nil;
    while((project = [reverseEnumerator nextObject])) {

        NSMenuItem *projectMenuItem = [[NSMenuItem alloc] initWithTitle:project.name
                                                                 action:@selector(projectClicked:)
                                                          keyEquivalent:@""];
        [projectMenuItem setTarget:self];
        [projectMenuItem setRepresentedObject:project];

        if(project == self.currentActivity.project) {
            [projectMenuItem setState:NSOnState];
        }
        
        [self.projectListMenuItem.submenu insertItem:projectMenuItem atIndex:0];
    }
    
    [self.menu update];
}

- (IBAction)stopRecordingActiveActivity:(id)sender
{
    [[KSProjectController sharedProjectController] stopRecordingCurrentActivitySuccess:^{
        // nothing to do?
    } failure:^(NSError *error) {
        // nothing to do?
    }];
}

- (IBAction)recordNewActivity:(id)sender
{
    // show 'record new activity' popup
    [self showRecordActivityWindowWithProject:nil
                                     activity:nil];
}

- (void)projectClicked:(NSMenuItem *)sender
{
    [self showRecordActivityWindowWithProject:sender.representedObject
                                     activity:nil];
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
        [[KSSensorController sharedSensorController] stopRecordingEventsFinished:nil];
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

#pragma mark - Helper
- (void)showRecordActivityWindowWithProject:(KSProject *) project activity:(KSActivity *)activity
{
    KSRecordActivityWindowController *controller = [[KSRecordActivityWindowController alloc] initWithProject:project
                                                                                                    activity:activity];
    [NSApp activateIgnoringOtherApps:YES];
    [controller showWindow:controller.window];
}

@end
