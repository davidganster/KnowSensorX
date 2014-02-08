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

- (IBAction)resetToDefaultsButtonClicked:(id)sender
{
    [[KSUserInfo sharedUserInfo] resetToDefaults];
    [self updateTextFields];
}

- (IBAction)applyButtonClicked:(id)sender
{
    KSUserInfo *userInfo = [KSUserInfo sharedUserInfo];
    [userInfo setUserID:self.userNameTextField.stringValue];
    [userInfo setDeviceID:self.deviceNameTextField.stringValue];
    [userInfo setServerAddress:self.serverAddressTextField.stringValue];
}

- (void)updateTextFields
{
    self.userNameTextField.stringValue      = [[KSUserInfo sharedUserInfo] userID];
    self.serverAddressTextField.stringValue = [[KSUserInfo sharedUserInfo] serverAddress];
    self.deviceNameTextField.stringValue    = [[KSUserInfo sharedUserInfo] deviceID];
    self.minimumIdleTimeLabel.stringValue   = [NSString stringWithFormat:@"%i", (int)[[KSUserInfo sharedUserInfo] minimumIdleTime] / 60];
}

- (IBAction)sliderDidChangeValue:(NSSlider *)sender
{
    NSInteger value = sender.integerValue;
    [[KSUserInfo sharedUserInfo] setMinimumIdleTime:value*60];
    self.minimumIdleTimeLabel.stringValue = [NSString stringWithFormat:@"%li", (long)value];
}

@end
