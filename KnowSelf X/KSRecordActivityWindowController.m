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
#import "KSActivity.h"
#import "KSProject.h"

#import <QuartzCore/QuartzCore.h>

#define RecordButtonTagRecord 1
#define RecordButtonTagStop   2

@interface KSRecordActivityWindowController ()

/// The project represented by the projectComboBox.
/// Will change upon autocompletion and selecting an object from the combo box.
@property (nonatomic, strong) KSProject  *project;

/// The activity represented by the activityComboBox.
/// Will change upon autocompletion and selecting an object from the combo box, but is ultimately ignored since a new activity has to be created anyway.
@property (nonatomic, strong) KSActivity *activity;

/// An array of KSProject objects, mirroring the KSProjectController's list.
/// It is kept for convenience access.
@property (nonatomic, strong) NSArray *projects;

// IBOutlets

/// The NSComboBox that handles selecting a project.
/// When a project is selected, this change is reflected in the activityComboBox's content.
@property (weak) IBOutlet NSComboBox *projectComboBox;

/// The NSComboBox that handles selecting an activity.
/// When the 'project' member is changed, the content of the activityComboBox will be reloaded to mirror the available activities in the selected project.
@property (weak) IBOutlet NSComboBox *activityComboBox;

/// The NSColorWell responsible for picking a color when a new project is created.
/// Disabled when an existing project is selected (changing color is not supported at the moment).
@property (weak) IBOutlet NSColorWell *projectColorWell;

/// Starts recording the activity/project.
/// Disabled when the project/activity field is not filled or the selected activity is already recording.
@property (weak) IBOutlet NSButton *recordButton;

// Some necessary outlets for fading status message in/out.
/// @ignore
@property (weak) IBOutlet NSImageView *willCreateNewProjectInfoImage;
/// @ignore
@property (weak) IBOutlet NSTextField *willCreateNewProjectInfoLabel;
/// @ignore
@property (weak) IBOutlet NSImageView *willCreateNewActivityInfoImage;
/// @ignore
@property (weak) IBOutlet NSTextField *willCreateNewActivityInfoLabel;
/// @ignore
@property (weak) IBOutlet NSImageView *willUseAlreadyExistingColorWarningImage;
/// @ignore
@property (weak) IBOutlet NSTextField *willUseAlreadyExistingColorWarningLabel;
/// @ignore
@property (weak) IBOutlet NSImageView *alreadyRecordingThisActivityImage;
/// @ignore
@property (weak) IBOutlet NSTextField *alreadyRecordingThisActivityLabel;

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

/**
 *  Resets the UI and sets the window to be 'floating' (that means it will not 
 *  hide behind other windows when it loses the focus).
 */
- (void)windowDidLoad
{
    if(self.project != nil)
        [self.projectComboBox  setStringValue:self.project.name];
    if(self.activity != nil)
        [self.activityComboBox setStringValue:self.activity.name];
    
    [self updateColorWell];
    [self updateRecordButtonState];
    self.willCreateNewProjectInfoImage.alphaValue        = 0.0f;
    self.willCreateNewProjectInfoLabel.alphaValue        = 0.0f;
    self.willCreateNewActivityInfoImage.alphaValue       = 0.0f;
    self.willCreateNewActivityInfoLabel.alphaValue       = 0.0f;
    self.willUseAlreadyExistingColorWarningImage.alphaValue = 0.0f;
    self.willUseAlreadyExistingColorWarningLabel.alphaValue = 0.0f;
    self.alreadyRecordingThisActivityImage.alphaValue       = 0.0f;
    self.alreadyRecordingThisActivityLabel.alphaValue       = 0.0f;

    [self.window setLevel:NSFloatingWindowLevel];
    [super windowDidLoad];
}

/**
 *  Triggered by clicking the record button or hitting return on the keyboard.
 *  Decides if the selected activity should be recorded or stopped based on the tag of `sender`.
 *
 *  @param sender The button that generated the event. Its tag can either be `RecordButtonTagRecord` or `RecordButtonTagStop`. If the tag does not equal either of those constants, this method does nothing.
 */
- (IBAction)recordButtonClicked:(NSButton *)sender
{
    if(sender.tag == RecordButtonTagRecord) {
        if([[KSProjectController sharedProjectController] currentlyRecordingActivity] &&
           ![[NSUserDefaults standardUserDefaults] boolForKey:kKSHasWarnedIfAlreadyRecordingActivityShouldBeStopped]) {
            // display warning dialog!
            [self showAlreadyRecordingWarning];
            return;
        }
        [self startRecordingActivity];
    } else if(sender.tag == RecordButtonTagStop) {
        [[KSProjectController sharedProjectController] stopRecordingCurrentActivitySuccess:^{
            // nothing
        } failure:^(NSError *error) {
            // nothing
        }];
        [self close];
    }
}

/**
 *  Called when the colorwell notifies the WindowController about the picked color.
 *  This method checks if the picked color is equal to the color of any of the projects
 *  and displays a warning if that is the case.
 *
 *  @param sender The colorwell that generated the event. Unused.
 */
- (IBAction)colorWellDidPickColor:(id)sender {
    for (KSProject *project in self.projects) {
        NSColor *color = [NSColor colorWithHexColorString:project.color];
        if([color isEqualTo:self.projectColorWell.color] &&
           !self.project &&
           self.projectComboBox.stringValue.length) {
            [self showColorAlreadyInUseWarning:YES];
            return;
        }
    }
    [self showColorAlreadyInUseWarning:NO];
}

/// Delegates to KSProjectController to start recording based on the current selection.
/// If the project does not exist yet, it will be created in the process; same goes for the activity.
/// @warning Invoking this method will close the window, /regardless/ of whether or not errors are encountered!

/**
 *  Delegates to KSProjectController to start recording based on the current selection.
 *  If the project does not exist yet, it will be created in the process; same goes for the activity.
 *  @warning Invoking this method will close the window, /regardless/ of whether or not errors are encountered!
 */
- (void)startRecordingActivity
{
    KSActivity *activityToRecord = nil;
    
//    LogMessage(kKSLogTagUI, kKSLogLevelInfo, @"Trying to start recording activity.");
    
    if(!self.project) {
        
//        LogMessage(kKSLogTagUI, kKSLogLevelInfo, @"Need to create new project first...");
        
        if(self.activity) {
            // impossible!
            LogMessage(kKSLogTagUI, kKSLogLevelError, @"Project == nil, but activity != nil! Abort send.");
            return;
        }
        KSProject *project = [[KSProject alloc] init];
        [project setName:[self.projectComboBox stringValue]];
        [project setColor:[[self.projectColorWell color] hexStringWithLeadingHashtag:YES]];
        
        activityToRecord = [self activityForProject:project];
        [[KSProjectController sharedProjectController] createProject:project success:^{
//            LogMessage(kKSLogTagUI, kKSLogLevelInfo, @"Successfully created project on server! ()%@", project);
            // project was successfully created!
            [[KSProjectController sharedProjectController] startRecordingActivity:activityToRecord];
//            LogMessage(kKSLogTagUI, kKSLogLevelInfo, @"Successfully started recording activity %@", [activityToRecord name]);
        } failure:^(NSError *error) {
            // what to do?
//            LogMessage(kKSLogTagUI, kKSLogLevelError, @"could not create project on server: %@", [error description]);
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
        [self.activityComboBox reloadData];
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
    LogMessage(kKSLogTagUI, kKSLogLevelError, @"Do not recognize combo box %@", aComboBox);
    return 0;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    if(aComboBox == self.projectComboBox) {
        return [self.projects[index] name];
    } else if(aComboBox == self.activityComboBox) {
        return [self.project.activities[index] name];
    }
    LogMessage(kKSLogTagUI, kKSLogLevelError, @"Do not recognize combo box %@", aComboBox);
    return nil;
}

#pragma mark - NSComboBoxDelegate
/**
 *  Called when the user enters text in either of the combo boxes.
 *  This will update the project/activity properties of the receiver.
 *
 *  @param notification Holds the combo box that generated the event. Used to figure out if a project/activity was selected.
 */
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
            LogMessage(kKSLogTagUI, kKSLogLevelError, @"Do not recognize combo box %@", comboBox);
            return;
        }
        [self updateRecordButtonState];
    }
}

/**
 *  Used for combo box autocompletion.
 *  Returns the completed string given the `string`.
 *
 *  @param aComboBox The combo box that asks for the completion.
 *  @param string    The string to be completed.
 *
 *  @return The completed string.
 */
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

/**
 *  Used for combo box autocompletion.
 *  Returns the index of the item with the given string value.
 *
 *  @param aComboBox The combo box that asks of the index.
 *  @param string    The value that will be searched.
 *
 *  @return The index of the searched string or NSNotFound if the string is not available in the given combo box.
 */
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

/**
 *  Called when the user clicks on an item in one of the combo boxes.
 *  Updates the project/activity and buttons accordingly.
 *
 *  @param notification Contains the object that generated the event. Used to figure out which combo box changed its selection.
 */
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSComboBox *comboBox = [notification object];
    if(comboBox == self.projectComboBox) {
        self.project = self.projects[comboBox.indexOfSelectedItem];
        [self.activityComboBox reloadData];
    } else if(comboBox == self.activityComboBox) {
        self.activity = self.project.activities[comboBox.indexOfSelectedItem];
    }
    [self updateRecordButtonState];
}

#pragma mark - Custom setters
/// @name Custom setters

/**
 *  Sets the given project object, updates the color well and shows the 'new project' info
 *  if appropriate.
 *
 *  @param project The project to set.
 */
- (void)setProject:(KSProject *)project
{
    _project = project;
    [self updateColorWell];
    BOOL shouldShowWarning = !project && self.projectComboBox.stringValue.length;
    [self showNewProjectInfo:shouldShowWarning];
    [self colorWellDidPickColor:nil]; // will check for color warning as well.
}

/**
 *  Sets the given activity object and shows the 'new activity' warning if appropriate.
 *
 *  @param activity The activity to set.
 */
- (void)setActivity:(KSActivity *)activity
{
    _activity = activity;
    BOOL shouldShowWarning = !activity && self.activityComboBox.stringValue.length;
    [self showNewActivityWarning:shouldShowWarning];
}


#pragma mark - Helpers
/// @name Helpers

/**
 *  Helper method to update the color well's color and state (enabled/disabled) based on the currenlty
 *  selected project.
 *  Also dismisses the color panel if it is currently showing.
 */
- (void)updateColorWell
{
    if(self.project.color != nil)
        [self.projectColorWell setColor:[NSColor colorWithHexColorString:self.project.color]];
    
    [self.projectColorWell setEnabled:(!self.project && self.projectComboBox.stringValue.length)];

    // dismiss color panel if it's no longer editable
    if(![self.projectColorWell isEnabled] && [NSColorPanel sharedColorPanelExists]) {
        [[NSColorPanel sharedColorPanel] close];
    }
}

/**
 *  Shows or hides the 'A new project will be created' info using a fade animation.
 *
 *  @param show Indicates if the info should be shown or hidden.
 */
- (void)showNewProjectInfo:(BOOL)show
{
    [self.willCreateNewProjectInfoImage.animator setAlphaValue:show];
    [self.willCreateNewProjectInfoLabel.animator setAlphaValue:show];
}

/**
 *  Shows or hides the 'A new activity will be created' info using a fade animation.
 *
 *  @param show Indicates if the info should be shown or hidden.
 */
- (void)showNewActivityWarning:(BOOL)show
{
    [self.willCreateNewActivityInfoImage.animator setAlphaValue:show];
    [self.willCreateNewActivityInfoLabel.animator setAlphaValue:show];
}

/**
 *  Shows or hides the 'This color is alreay in use' warning using a fade animation.
 *
 *  @param show Indicates if the warning should be shown or hidden.
 */
- (void)showColorAlreadyInUseWarning:(BOOL)show
{
    [self.willUseAlreadyExistingColorWarningImage.animator setAlphaValue:show];
    [self.willUseAlreadyExistingColorWarningLabel.animator setAlphaValue:show];
}

/**
 *  Shows or hides the 'This activity is already recording' info using a fade animation.
 *
 *  @param show Indicates if the info should be shown or hidden.
 */
- (void)showAlreadyRecordingThisActivityWarning:(BOOL)show
{
    [self.alreadyRecordingThisActivityImage.animator setAlphaValue:show];
    [self.alreadyRecordingThisActivityLabel.animator setAlphaValue:show];
}

/**
 *  Updates the state of the record button depending on the values of the project/activity combo boxes.
 *  It also swaps the record button for a 'Stop' button if the selected activity is already recording.
 */
- (void)updateRecordButtonState
{
    BOOL isAlreadyRecordingThisActivity = NO;
    KSActivity *currentlyRecordingActvitiy = [[KSProjectController sharedProjectController] currentlyRecordingActivity];
    
    if(self.project &&
       self.project == currentlyRecordingActvitiy.project &&
       [self.activityComboBox.stringValue isEqualToString:currentlyRecordingActvitiy.name]) {
        isAlreadyRecordingThisActivity = YES;
        [self showAlreadyRecordingThisActivityWarning:YES];
    } else {
        [self showAlreadyRecordingThisActivityWarning:NO];
    }
    
    if(!isAlreadyRecordingThisActivity &&
       ((self.projectComboBox.stringValue.length && self.activityComboBox.stringValue.length) ||
        (self.project && self.activity))) {
           
        [self.recordButton setTitle:@"Record"];
        [self.recordButton setTag:RecordButtonTagRecord];
        [self.recordButton setEnabled:YES];
    } else if(isAlreadyRecordingThisActivity) {
        [self.recordButton setTitle:@"Stop"];
        [self.recordButton setTag:RecordButtonTagStop];
        [self.recordButton setEnabled:YES];
    } else {
        [self.recordButton setTitle:@"Record"];
        [self.recordButton setTag:RecordButtonTagRecord];
        [self.recordButton setEnabled:NO];
    }
}

/**
 *  Creates a new KSActivity with the given project and string value of the activityComboBox.
 *  @note The newly created activity will be added to the given project's `activities` relationship once the activity has been pushed to the server (which will return a new project list containing this activity).
 *
 *  @param project The project that will be connected to the new activity.
 *
 *  @return A new KSActivity object initialized to the current time, the name from the activityCombobox, and the given project.
 */
- (KSActivity *)activityForProject:(KSProject *)project
{
    KSActivity *activity = nil;
    activity = [[KSActivity alloc] init];
    [activity setName:[self.activityComboBox stringValue]];
    [activity setStartDate:[[NSDate alloc] init]];
    [activity setActivityID:@""]; // empty string for export.
    [activity setProject:project];
    [activity setProjectName:project.name];
    return activity;
}

/**
 *  Helper to display an alert if another activity is already recording when the user clicks 'Record'.
 *  This alert will only be displayed if the user has not ticked its suppressionButton before (this value
 *  is stored in the NSUserDefaults for the key `kKSHasWarnedIfAlreadyRecordingActivityShouldBeStopped`).
 */
- (void)showAlreadyRecordingWarning
{
    NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"Another activity (\"%@\") is already recording!", [[[KSProjectController sharedProjectController] currentlyRecordingActivity] name]]
                            defaultButton:@"Continue"
                          alternateButton:@"Cancel"
                              otherButton:nil
                informativeTextWithFormat:@"Click 'Continue' to stop the current activity and start recording the new one."];
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
