//
//  KSSettingsViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSettingsViewController.h"
#import "KSUserInfo.h"

@interface KSSettingsViewController ()

@property (weak) IBOutlet NSTextField *minimumIdleTimeLabel;
@property (weak) IBOutlet NSSlider *minimumIdleTimeSlider;
@property (weak) IBOutlet NSButton *shouldRecordScreenshotsCheckbox;
@property (weak) IBOutlet NSSlider *screenshotQualitySlider;
@end

@implementation KSSettingsViewController

- (id)init
{
    self = [super initWithNibName:@"KSSettingsViewController" bundle:nil];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userNameTextField.stringValue      = [[KSUserInfo sharedUserInfo] userID];
    self.serverAddressTextField.stringValue = [[KSUserInfo sharedUserInfo] serverAddress];
    self.deviceNameTextField.stringValue    = [[KSUserInfo sharedUserInfo] deviceID];
    int idleTimeInMinutes = [[KSUserInfo sharedUserInfo] minimumIdleTime] / 60;
    [self.minimumIdleTimeSlider setIntegerValue:idleTimeInMinutes];
    self.minimumIdleTimeLabel.stringValue = [NSString stringWithFormat:@"%i", idleTimeInMinutes];
    self.shouldRecordScreenshotsCheckbox.state = [[KSUserInfo sharedUserInfo] shouldRecordScreenshots];
    [self.screenshotQualitySlider setIntegerValue:[[KSUserInfo sharedUserInfo] screenshotQuality]];
}

- (IBAction)textFieldDidReturn:(NSTextField *)sender
{
    KSUserInfo *userInfo = [KSUserInfo sharedUserInfo];
    if([sender.identifier isEqualToString:kKSUserNameTextFieldIdentifier]) {
        [userInfo setUserID:sender.stringValue];
    } else if([sender.identifier isEqualToString:kKSDeviceNameTextFieldIdentifier]) {
        [userInfo setDeviceID:sender.stringValue];
    } else if([sender.identifier isEqualToString:kKSServerAddressTextFieldIdentifier]) {
        [userInfo setServerAddress:sender.stringValue];
    } else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"Unkown identifier '%@'", sender.identifier);
    }
}

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

- (IBAction)exportSettingsButtonClicked:(NSButton *)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setCanCreateDirectories:YES];
    [savePanel setCanSelectHiddenExtension:NO];
    [savePanel setAllowedFileTypes:@[@"ksxsettings"]];
    [savePanel setAllowsOtherFileTypes:NO];
    [savePanel setPreventsApplicationTerminationWhenModal:YES];
    [savePanel setNameFieldStringValue:@"Settings"];
    
    if([savePanel runModal] == NSFileHandlingPanelOKButton) {
        NSURL *url = [savePanel URL];
        if(![[KSUserInfo sharedUserInfo] saveUserInfoToPath:[url absoluteURL] includeUserData:NO]) {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Could not save settings"];
            [alert setInformativeText:[NSString stringWithFormat:@"Settings could not be exported - you might not have permissions to write to %@!", url.absoluteString]];
            [alert runModal];
        }
    }
}

- (IBAction)resetToDefaultsButtonClicked:(id)sender
{
    [[KSUserInfo sharedUserInfo] resetToDefaults];
    [self updateUI];
}

- (void)updateUI
{
    self.userNameTextField.stringValue      = [[KSUserInfo sharedUserInfo] userID];
    self.serverAddressTextField.stringValue = [[KSUserInfo sharedUserInfo] serverAddress];
    self.deviceNameTextField.stringValue    = [[KSUserInfo sharedUserInfo] deviceID];
    self.minimumIdleTimeLabel.stringValue   = [NSString stringWithFormat:@"%i", (int)[[KSUserInfo sharedUserInfo] minimumIdleTime] / 60];
    self.screenshotQualitySlider.integerValue = [[KSUserInfo sharedUserInfo] screenshotQuality];
    self.shouldRecordScreenshotsCheckbox.state = [[KSUserInfo sharedUserInfo] shouldRecordScreenshots];
}

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

- (IBAction)recordScreenshotsValueChanged:(NSButton *)sender
{
    [[KSUserInfo sharedUserInfo] setShouldRecordScreenshots:sender.state];
}

@end
