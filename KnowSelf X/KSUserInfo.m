//
//  KSUserInfo.m
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSUserInfo.h"

@implementation KSUserInfo

+ (KSUserInfo *)sharedUserInfo
{
    static KSUserInfo *_sharedUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUserInfo = [[KSUserInfo alloc] init];
    });
    
    return _sharedUserInfo;
}


- (id)init
{
    self = [super init];
    if(self) {
        [self loadValuesFromUserDefaults];
    }
    return self;
}

- (void)loadValuesFromUserDefaults
{
    _deviceID = [[NSUserDefaults standardUserDefaults] stringForKey:kKSUserInfoDeviceNameKey];
    if(!_deviceID) {
        _deviceID = (__bridge NSString *)SCDynamicStoreCopyComputerName(NULL, NULL);
        [[NSUserDefaults standardUserDefaults] setObject:_deviceID forKey:kKSUserInfoDeviceNameKey];
    }
    
    _userID = [[NSUserDefaults standardUserDefaults] stringForKey:kKSUserInfoUserNameKey];
    if(!_userID) {
        _userID = NSFullUserName();
        [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:kKSUserInfoUserNameKey];
    }
    
    _serverAddress = [[NSUserDefaults standardUserDefaults] stringForKey:kKSUserInfoServerAddressKey];
    if(!_serverAddress) {
        _serverAddress = kKSServerBaseURL;
        [[NSUserDefaults standardUserDefaults] setObject:_serverAddress forKey:kKSUserInfoServerAddressKey];
    }
    
    NSArray *applications = [[NSUserDefaults standardUserDefaults] arrayForKey:kKSUserInfoSpecialApplicationsKey];
    if(!applications) {
        applications = [NSArray array];
    }
    _specialApplications = [NSSet setWithArray:applications];

    if([KSUtils isFirstStart]) {
        _specialApplicationsAreBlacklist = YES;
        [[NSUserDefaults standardUserDefaults] setBool:_specialApplicationsAreBlacklist forKey:kKSUserInfoSpecialApplicationsAreBlacklistKey];
    }
}

- (void)resetToDefaults
{
    self.serverAddress = kKSServerBaseURL;
    self.userID = NSFullUserName();
    self.deviceID = (__bridge NSString *)SCDynamicStoreCopyComputerName(NULL, NULL);
    self.specialApplications = [NSSet set];
    self.specialApplicationsAreBlacklist = YES;
}

#pragma mark Setters

- (void)setUserID:(NSString *)userID
{
    _userID = userID;
    if(userID == nil)
        [[NSUserDefaults standardUserDefaults] setNilValueForKey:kKSUserInfoUserNameKey];
    else
        [[NSUserDefaults standardUserDefaults] setObject:_userID
                                                  forKey:kKSUserInfoUserNameKey];
}

- (void)setDeviceID:(NSString *)deviceID
{
    _deviceID = deviceID;
    if(deviceID == nil)
       [[NSUserDefaults standardUserDefaults] setNilValueForKey:kKSUserInfoDeviceNameKey];
    else
        [[NSUserDefaults standardUserDefaults] setObject:_deviceID
                                                  forKey:kKSUserInfoDeviceNameKey];
}

- (void)setServerAddress:(NSString *)serverAddress
{
    _serverAddress = serverAddress;
    if(!serverAddress)
        [[NSUserDefaults standardUserDefaults] setNilValueForKey:kKSUserInfoServerAddressKey];
    else
        [[NSUserDefaults standardUserDefaults] setObject:_serverAddress
                                                  forKey:kKSUserInfoServerAddressKey];
}


- (void)setSpecialApplications:(NSSet *)specialApplications
{
    _specialApplications = specialApplications;
    if(!specialApplications) {
        [[NSUserDefaults standardUserDefaults] setNilValueForKey:kKSUserInfoSpecialApplicationsKey];
    } else {
        NSArray *applications = [_specialApplications allObjects];
        [[NSUserDefaults standardUserDefaults] setObject:applications
                                                  forKey:kKSUserInfoSpecialApplicationsKey];
    }
}


- (void)setSpecialApplicationsAreBlacklist:(BOOL)specialApplicationsAreBlacklist
{
    _specialApplicationsAreBlacklist = specialApplicationsAreBlacklist;
    [[NSUserDefaults standardUserDefaults] setBool:_specialApplicationsAreBlacklist
                                            forKey:kKSUserInfoSpecialApplicationsAreBlacklistKey];
}

@end
