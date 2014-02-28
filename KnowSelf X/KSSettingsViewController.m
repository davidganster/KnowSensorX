//
//  KSSettingsViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSettingsViewController.h"
#import "KSUserInfo.h"
#import "KSAPIClient.h"

@interface KSSettingsViewController ()

// IBOutlets, see nib file for info.
/// This view is actually not needed anymore, it was once used as a workaround for a
/// bug in interface builder.
/// Since this bug has been resolved, this view doesn't do anything - but removing it would require
/// moving all UI elements manually, which is more hassle than it's worth.
@property (weak) IBOutlet NSView *hackToFixIB;
/// Text field for entering the user name.
/// The entered value will be saved to KSUserInfo upon end editing.
@property (weak) IBOutlet NSTextField *userNameTextField;
/// Text field for entering the server address.
/// The entered value will be saved to KSUserInfo upon end editing.
@property (weak) IBOutlet NSTextField *serverAddressTextField;
/// Text field for entering the device name.
/// The entered value will be saved to KSUserInfo upon end editing.
@property (weak) IBOutlet NSTextField *deviceNameTextField;
/// Text field for displaying the minimum idle time.
/// Used as a label to display the value selected using the minimumIdleTimeSlider.
@property (weak) IBOutlet NSTextField *minimumIdleTimeLabel;
/// Slider for setting the minimum idle time.
/// The entered value will be saved to KSUserInfo upon releasing.
@property (weak) IBOutlet NSSlider *minimumIdleTimeSlider;
/// Slider for setting the screenshot quality.
/// The entered value will be saved to KSUserInfo upon releasing.
@property (weak) IBOutlet NSSlider *screenshotQualitySlider;
/// The image cell for displaying the current server status.
/// The used image will either be NSStatusAvailable, NSStatusUnavailable or NSStatusNone.
@property (weak) IBOutlet NSImageCell *serverStatusIndicatorImage;

/// The value of this checkbox is connected to all labels below it (everything that has something to
/// do with screenshot quality) using cocoa bindings to enable/disable them.
/// Take a look at the corresponding .xib file for more info.
@property (weak) IBOutlet NSButton *shouldRecordScreenshotsCheckbox;

/// Set to the value in the KSUserInfo when loading the view for the first time.
/// Used to determine if we can show a valid server status indicator.
@property(nonatomic, strong) NSString *knownServerReachabilityURL;

@end

@implementation KSSettingsViewController

/**
 *  Designated initializer. Do not use another method to initialize a KSSettingsViewController!
 *  This method will load the appropriate nib file (KSSettingsViewController) and subscribe to
 *  kKSNotificationKeyServerReachable and kKSNotificationKeyServerUnreachable notifications.
 *
 *  @return The fully initialized KSSettingsViewController.
 */
- (id)init
{
    self = [super initWithNibName:@"KSSettingsViewController" bundle:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateServerStatusImage)
                                                 name:kKSNotificationKeyServerReachable
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateServerStatusImage)
                                                 name:kKSNotificationKeyServerUnreachable
                                               object:nil];
    return self;
}

/**
 *  Overwritten to update the UI and base server address when the view becomes visible.
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.knownServerReachabilityURL = [[KSUserInfo sharedUserInfo] serverAddress];
    [self updateUI];
}

/**
 *  Sent when any of the text fields (server address, user name, device ID) end editing.
 *  This method will update the according KSUserInfo field.
 *
 *  @param sender The text field that sent the event.
 */
- (IBAction)textFieldDidReturn:(NSTextField *)sender
{
    KSUserInfo *userInfo = [KSUserInfo sharedUserInfo];
    if([sender.identifier isEqualToString:kKSUserNameTextFieldIdentifier]) {
        [userInfo setUserID:sender.stringValue];
    } else if([sender.identifier isEqualToString:kKSDeviceNameTextFieldIdentifier]) {
        [userInfo setDeviceID:sender.stringValue];
    } else if([sender.identifier isEqualToString:kKSServerAddressTextFieldIdentifier]) {
        [userInfo setServerAddress:sender.stringValue];
        [self updateServerStatusImage];
    } else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"Unkown identifier '%@'", sender.identifier);
    }
}

/**
 *  Opens an NSOpenPanel that lets the user choose from where to import the file.
 *  Passes the obtained URL to the KSUserInfo class for further processing.
 *
 *  @param sender The button that generated the event. Unused.
 */
- (IBAction)importSettingsButtonClicked:(NSButton *)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowedFileTypes:@[@"ksxsettings"]];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    [openPanel setCanCreateDirectories:NO];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setCanChooseFiles:YES];
    
    if([openPanel runModal] == NSFileHandlingPanelOKButton) {
        NSURL *url = [openPanel URL];
        if(![[KSUserInfo sharedUserInfo] loadUserInfoFromPath:[url absoluteURL]]) {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Could not load settings"];
            [alert setInformativeText:@"Settings could not be imported - the file might be corrupt."];
            [alert runModal];
        }
        [self updateUI];
    }
}

/**
 *  Opens an NSOpenPanel that lets the user choose where to export the file.
 *  Passes the obtained URL to the KSUserInfo class for further processing.
 *
 *  @param sender The button that generated the event. Unused.
 */
- (IBAction)exportSettingsButtonClicked:(NSButton *)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setCanCreateDirectories:YES];
    [savePanel setCanSelectHiddenExtension:NO];
    [savePanel setAllowedFileTypes:@[@"ksxsettings"]];
    [savePanel setAllowsOtherFileTypes:NO];
    [savePanel setPreventsApplicationTerminationWhenModal:YES];
    [savePanel setNameFieldStringValue:@"Settings"];
    
    NSButton *button = [[NSButton alloc] init];
    [button setButtonType:NSSwitchButton];
    [button setTitle:@"Export personal data"];
    [button sizeToFit];
    [savePanel setAccessoryView:button];

    if([savePanel runModal] == NSFileHandlingPanelOKButton) {
        NSURL *url = [savePanel URL];
        BOOL includeUserData = ((NSButton *)savePanel.accessoryView).state == NSOnState;
        if(![[KSUserInfo sharedUserInfo] saveUserInfoToPath:[url absoluteURL]
                                            includeUserData:includeUserData]) {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Could not save settings"];
            [alert setInformativeText:[NSString stringWithFormat:@"Settings could not be exported - you might not have permissions to write to %@!", url.absoluteString]];
            [alert runModal];
        }
    }
}

/**
 *  Resets all values to their defaults - both in KSUserInfo and the GUI.
 *
 *  @param sender The button that generated the event. Unused.
 */
- (IBAction)resetToDefaultsButtonClicked:(id)sender
{
    [[KSUserInfo sharedUserInfo] resetToDefaults];
    [self updateUI];
}

/**
 *  Called when any of the sliders (minimumIdleTimeSlider or screenshotQualitySlider) change their value.
 *  The minimumIdleTimeSlider is continuous and updates the minimum idle time in KSUserInfo.
 *  The screenshotQualitySlider is discrete and directly passes its value to KSUserInfo.
 *
 *  @param sender The NSSlider that generated the event. Used for determining which value to change.
 */
- (IBAction)sliderDidChangeValue:(NSSlider *)sender
{
    if(sender == self.minimumIdleTimeSlider) {
        NSInteger value = sender.integerValue;
        [[KSUserInfo sharedUserInfo] setMinimumIdleTime:value*60];
        self.minimumIdleTimeLabel.stringValue = [NSString stringWithFormat:@"%li", (long)value];
    } else if(sender == self.screenshotQualitySlider) {
        NSInteger value = sender.integerValue;
        [[KSUserInfo sharedUserInfo] setScreenshotQuality:(int)value];
    }
}

/**
 *  Sent when the 'Record screenshots' check box changes its state.
 *  The state is simply sent to KSUserInfo as the 'shouldRecordScreenshots' property.
 *
 *  @param sender The button that generated the event. Its state will be used as the new 'shouldRecordScreenshots' property in KSUserInfo.
 */
- (IBAction)recordScreenshotsValueChanged:(NSButton *)sender
{
    [[KSUserInfo sharedUserInfo] setShouldRecordScreenshots:sender.state];
}

#pragma mark - Helper
/**
 *  Helper method for updating all UI fields to their corresponding KSUserInfo values.
 */
- (void)updateUI
{
    self.userNameTextField.stringValue      = [[KSUserInfo sharedUserInfo] userID];
    self.serverAddressTextField.stringValue = [[KSUserInfo sharedUserInfo] serverAddress];
    self.deviceNameTextField.stringValue    = [[KSUserInfo sharedUserInfo] deviceID];
    int idleTimeInMinutes = [[KSUserInfo sharedUserInfo] minimumIdleTime] / 60;
    self.minimumIdleTimeLabel.stringValue   = [NSString stringWithFormat:@"%i", idleTimeInMinutes];
    [self.minimumIdleTimeSlider setIntegerValue:idleTimeInMinutes];
    self.shouldRecordScreenshotsCheckbox.state = [[KSUserInfo sharedUserInfo] shouldRecordScreenshots];
    self.screenshotQualitySlider.integerValue = [[KSUserInfo sharedUserInfo] screenshotQuality];
    [self updateServerStatusImage];
}

/**
 *  Updates the 'serverStatusIndicatorImage' to the current reachability state reported by the
 *  KSAPIClient.
 */
- (void)updateServerStatusImage
{
    if(![self.serverAddressTextField.stringValue isEqualToString:self.knownServerReachabilityURL]) {
        // not the same address, don't know about reachability!
        self.serverStatusIndicatorImage.image = [NSImage imageNamed:@"NSStatusNone"];
    } else if([[KSAPIClient sharedClient] serverReachable]) {
        self.serverStatusIndicatorImage.image = [NSImage imageNamed:@"NSStatusAvailable"];
    } else {
        self.serverStatusIndicatorImage.image = [NSImage imageNamed:@"NSStatusUnavailable"];
    }
}


@end
