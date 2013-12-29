//
//  KSRecordActivityWindowController.m
//  KnowSensor X
//
//  Created by David Ganster on 28/12/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSRecordActivityWindowController.h"
#import "KSProjectController.h"
#import "NSColor+HexParsing.h"
#import "KSActivity+Addons.h"
#import "KSProject+Addons.h"

#import <QuartzCore/QuartzCore.h>

@interface KSRecordActivityWindowController ()

@property (weak) IBOutlet NSComboBox *projectComboBox;
@property (weak) IBOutlet NSComboBox *activityComboBox;
@property (weak) IBOutlet NSColorWell *projectColorWell;
@property (weak) IBOutlet NSButton *recordButton;

@property (nonatomic, strong) KSProject  *project;
@property (nonatomic, strong) KSActivity *activity;

@property (nonatomic, strong) NSArray *projects;

@property (weak) IBOutlet NSImageView *willCreateNewProjectWarningImage;
@property (weak) IBOutlet NSTextField *willCreateNewProjectWarningLabel;

@property (weak) IBOutlet NSImageView *willCreateNewActivityWarningImage;
@property (weak) IBOutlet NSTextField *willCreateNewActivityWarningLabel;


@end

@implementation KSRecordActivityWindowController

- (id)initWithProject:(KSProject *)project
             activity:(KSActivity *)activity
{
    self = [super initWithWindowNibName:@"KSRecordActivityWindowController"];
    if (self) {
        self.activity = activity;
        self.project = project;
        
        [[KSProjectController sharedProjectController] addObserverForProjectRelatedEvents:self];
        self.projects = [[KSProjectController sharedProjectController] currentProjectList];
    }
    return self;
}

- (void)windowDidLoad
{
    [self resetComboBoxes];
    [self updateRecordButtonState];
    self.willCreateNewProjectWarningImage.alphaValue = 0.0f;
    self.willCreateNewProjectWarningLabel.alphaValue = 0.0f;
    self.willCreateNewActivityWarningImage.alphaValue = 0.0f;
    self.willCreateNewActivityWarningLabel.alphaValue = 0.0f;

    [self.window setLevel:NSFloatingWindowLevel];
    [super windowDidLoad];
}

- (IBAction)recordButtonClicked:(id)sender
{
    // TODO: create project/activity from active selections and send everything to the server.
}

#pragma mark - KSProjectControllerEventObserver
- (void)          projectController:(KSProjectController *)controller
projectListChangedWithAddedProjects:(NSArray *)addedObjects
                    deletedProjects:(NSArray *)deletedProjects
{
    // UI updates are always running on the main thread:
    dispatch_async(dispatch_get_main_queue(), ^{
        self.projects = controller.currentProjectList;
        [self.projectComboBox reloadData];
    });
}

- (void)projectController:(KSProjectController *)controller activeActivityChangedToActivity:(KSActivity *)activity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activity = activity;
        self.project  = activity.project;
    });
}


#pragma mark - NSComboBoxDataSource
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    if(aComboBox == self.projectComboBox) {
        return [self.projects count];
    } else if(aComboBox == self.activityComboBox) {
        return [self.project.activities count];
    }
    LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelError, @"Do not recognize combo box %@", aComboBox);
    return 0;
}


- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    if(aComboBox == self.projectComboBox) {
        return [self.projects[index] name];
    } else if(aComboBox == self.activityComboBox) {
        return [self.project.activities[index] name];
    }
    LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelError, @"Do not recognize combo box %@", aComboBox);
    return nil;
}

#pragma mark - NSComboBoxDelegate
- (void)controlTextDidChange:(NSNotification *)notification
{
    NSComboBox *comboBox = notification.object;
    if([comboBox isKindOfClass:[NSComboBox class]]) {
        NSString *completedString = [self comboBox:comboBox completedString:[comboBox stringValue]];
        NSInteger index = [self comboBox:comboBox indexOfItemWithStringValue:completedString];
        if(comboBox == self.projectComboBox) {
            self.project = (index != NSNotFound) ? self.projects[index] : nil;
        } else if(comboBox == self.activityComboBox) {
            self.activity = (index != NSNotFound) ? [self.project activities][index] : nil;
        } else {
            LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelError, @"Do not recognize combo box %@", comboBox);
            return;
        }
        [self updateRecordButtonState];
    }
}

- (NSString *)comboBox:(NSComboBox *)aComboBox completedString:(NSString *)string
{
    if(!string) return nil;
    
    if(aComboBox == self.projectComboBox) {
        for (KSProject *project in self.projects)
            if([project.name hasPrefix:string])
                return project.name;
    } else if(aComboBox == self.activityComboBox) {
        for (KSActivity *activity in self.project.activities)
            if([activity.name hasPrefix:string])
                return activity.name;
    }
    return nil;
}

- (NSUInteger)comboBox:(NSComboBox *)aComboBox indexOfItemWithStringValue:(NSString *)string
{
    if(!string) return NSNotFound;
    
    NSUInteger index = 0;
    if(aComboBox == self.projectComboBox) {
        for (KSProject *project in self.projects) {
            if([project.name isEqualToString:string])
                return index;
            index++;
        }
    } else if(aComboBox == self.activityComboBox) {
        for (KSActivity *activity in self.project.activities) {
            if([activity.name hasPrefix:string])
                return index;
            index++;
        }
    }
    return NSNotFound;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSComboBox *comboBox = [notification object];
    if(comboBox == self.projectComboBox) {
        self.project = self.projects[comboBox.indexOfSelectedItem];
        [self.activityComboBox reloadData];
    }
}

#pragma mark - Custom setters
- (void)setProject:(KSProject *)project
{
    _project = project;
    [self updateColorWell];
    BOOL shouldShowWarning = !project && self.projectComboBox.stringValue.length;
    [self showNewProjectWarning:shouldShowWarning];
}

- (void)setActivity:(KSActivity *)activity
{
    _activity = activity;
    BOOL shouldShowWarning = !activity && self.activityComboBox.stringValue.length;
    [self showNewActivityWarning:shouldShowWarning];
}

#pragma mark - Helpers
- (void)resetComboBoxes
{
    if(self.project != nil)
        [self.projectComboBox  setStringValue:self.project.name];
    if(self.activity != nil)
        [self.activityComboBox setStringValue:self.activity.name];
}

- (void)updateColorWell
{
    if(self.project.color != nil)
        [self.projectColorWell setColor:[NSColor colorWithHexColorString:self.project.color]];
    
    [self.projectColorWell setEnabled:!self.project];
}

- (void)showNewProjectWarning:(BOOL)show
{
    [self.willCreateNewProjectWarningImage.animator setAlphaValue:show];
    [self.willCreateNewProjectWarningLabel.animator setAlphaValue:show];
}

- (void)showNewActivityWarning:(BOOL)show
{
    [self.willCreateNewActivityWarningImage.animator setAlphaValue:show];
    [self.willCreateNewActivityWarningLabel.animator setAlphaValue:show];
}

- (void)updateRecordButtonState
{
    if(self.projectComboBox.stringValue.length && self.activityComboBox.stringValue.length)
        [self.recordButton setEnabled:YES];
    else
        [self.recordButton setEnabled:NO];
}

@end
