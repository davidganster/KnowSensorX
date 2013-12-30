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

@property (weak) IBOutlet NSImageView *willUseAlreadyExistingColorWarningImage;
@property (weak) IBOutlet NSTextField *willUseAlreadyExistingColorWarningLabel;

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
    self.willUseAlreadyExistingColorWarningImage.alphaValue = 0.0f;
    self.willUseAlreadyExistingColorWarningLabel.alphaValue = 0.0f;

    [self.window setLevel:NSFloatingWindowLevel];
    [super windowDidLoad];
}

- (IBAction)recordButtonClicked:(id)sender
{
    if([[KSProjectController sharedProjectController] currentlyRecordingActivity] &&
       ![[NSUserDefaults standardUserDefaults] boolForKey:kKSHasWarnedIfAlreadyRecordingActivityShouldBeStopped]) {
        // display warning dialog!
        [self showAlreadyRecordingWarning];
        return;
    }
    
    [self startRecordingActivity];
}

- (IBAction)colorWellDidPickColor:(id)sender {
    for (KSProject *project in self.projects) {
        NSColor *color = [NSColor colorWithHexColorString:project.color];
        if([color isEqualTo:self.projectColorWell.color]) {
            [self showColorAlreadyInUseWarning:YES];
            return;
        }
    }
    [self showColorAlreadyInUseWarning:NO];
}

/// Delegates to KSProjectController to start recording based on the current selection.
/// If the project does not exist yet, it will be created in the process; same goes for the activity.
/// @warning Invoking this method will close the window, /regardless/ of whether or not errors are encountered!
- (void)startRecordingActivity
{
    KSActivity *activityToRecord = nil;
    
    LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelInfo, @"Trying to start recording activity.");
    
    if(!self.project) {
        if(self.activity) {
            // impossible!
            LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelError, @"Project == nil, but activity != nil! Abort send.");
            return;
        }
        KSProject *project = [KSProject createInContext:[NSManagedObjectContext defaultContext]];
        [project setName:[self.projectComboBox stringValue]];
        [project setColor:[[self.projectColorWell color] hexStringWithLeadingHashtag:YES]];
        
        activityToRecord = [self activityForProject:project];
        [[KSProjectController sharedProjectController] createProject:project success:^{
            // project was successfully created!
            [[KSProjectController sharedProjectController] startRecordingActivity:activityToRecord];
            LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelInfo, @"Successfully started recording activity %@", [activityToRecord name]);
        } failure:^(NSError *error) {
            // what to do?
            LogMessage(kKSLogTagRecordActivityWindow, kKSLogLevelError, @"could not create project on server: %@", [error description]);
        }];
    } else {
        activityToRecord = [self activityForProject:self.project];
        [[KSProjectController sharedProjectController] startRecordingActivity:activityToRecord];
    }
    
    // after trying to record the activity, let's close the window (regardless of success/failure)
    [self close];
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

    // dismiss color panel if it's no longer editable
    if(![self.projectColorWell isEnabled] && [NSColorPanel sharedColorPanelExists]) {
        [[NSColorPanel sharedColorPanel] close];
    }
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

- (void)showColorAlreadyInUseWarning:(BOOL)show
{
    [self.willUseAlreadyExistingColorWarningImage.animator setAlphaValue:show];
    [self.willUseAlreadyExistingColorWarningLabel.animator setAlphaValue:show];
}

- (void)updateRecordButtonState
{
    if(self.projectComboBox.stringValue.length && self.activityComboBox.stringValue.length)
        [self.recordButton setEnabled:YES];
    else
        [self.recordButton setEnabled:NO];
}

/// Either returns self.activity (if not nil), or creates a new KSActivity in the defaultContext.
/// @note The newly created activity will be added to the given project's `activities` relationship.
- (KSActivity *)activityForProject:(KSProject *)project
{
    if(self.activity) return self.activity;
    
    KSActivity *activity = [KSActivity createInContext:[NSManagedObjectContext defaultContext]];
    [activity setName:[self.activityComboBox stringValue]];
    [activity setColor:[[self.projectColorWell color] hexStringWithLeadingHashtag:YES]];
    [activity setStartDate:[NSDate date]];
    [activity setProjectName:[project name]];
    [activity setProject:project];
    return activity;
}


- (void)showAlreadyRecordingWarning
{
    NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"Another activity (%@) is already recording and will be stopped. Abort/Retry/Fail?", [[[KSProjectController sharedProjectController] currentlyRecordingActivity] name]]
                            defaultButton:@"Continue"
                          alternateButton:@"Cancel"
                              otherButton:nil
                informativeTextWithFormat:nil];
    [alert setShowsSuppressionButton:YES];
    
    [alert setShowsHelp:NO];
    
    NSInteger returnCode = [alert runModal];
    
    if([[alert suppressionButton] state] == NSOnState) {
        [[NSUserDefaults standardUserDefaults] setBool:YES
                                                forKey:kKSHasWarnedIfAlreadyRecordingActivityShouldBeStopped];
    }
    
    switch (returnCode) {
        case NSAlertDefaultReturn:
            // Continue onwards
            [self startRecordingActivity];
            break;
        case NSAlertAlternateReturn:
            // don't do anything
            break;
        default:
            break;
    }
}

@end
