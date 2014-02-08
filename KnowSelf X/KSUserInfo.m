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
    _specialApplications = [NSMutableSet setWithArray:applications];

    _specialApplicationsAreBlacklist = [[NSUserDefaults standardUserDefaults] boolForKey:kKSUserInfoSpecialApplicationsAreBlacklistKey];
    if([KSUtils isFirstStart]) {
        _specialApplicationsAreBlacklist = YES;
        [[NSUserDefaults standardUserDefaults] setBool:_specialApplicationsAreBlacklist
                                                forKey:kKSUserInfoSpecialApplicationsAreBlacklistKey];
    }
    
    _URLMappings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kKSUserInfoURLMappingsKey] mutableCopy];
    if(!_URLMappings) {
        _URLMappings = [@{@"127.0.0.1:8182" : @"KnowSelf WebApp",
                          @"http://127.0.0.1:8182/?showobservations=1" : @"KnowSelf Diary",
                          @"www.google.*" : @"Google"} mutableCopy];
    }
}

- (void)resetToDefaults
{
    self.serverAddress = kKSServerBaseURL;
    self.userID = NSFullUserName();
    self.deviceID = (__bridge NSString *)SCDynamicStoreCopyComputerName(NULL, NULL);
    self.specialApplications = [NSMutableSet set];
    self.specialApplicationsAreBlacklist = YES;
    self.URLMappings = [@{@"127.0.0.1:8182" : @"KnowSelf WebApp",
                          @"http://127.0.0.1:8182/?showobservations=1" : @"KnowSelf Diary",
                          @"www.google.*" : @"Google"} mutableCopy];
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
    // we only ever assign mutable copies to our object, and act as if it was immutable.
    _specialApplications = [specialApplications mutableCopy];
    if(!specialApplications) {
        [[NSUserDefaults standardUserDefaults] setNilValueForKey:kKSUserInfoSpecialApplicationsKey];
    } else {
        NSArray *applications = [_specialApplications allObjects];
        [[NSUserDefaults standardUserDefaults] setObject:applications
                                                  forKey:kKSUserInfoSpecialApplicationsKey];
    }
}

- (void)addSpecialApplicationsObject:(NSString *)object
{
    NSMutableSet *applications = (NSMutableSet *)self.specialApplications;
    [applications addObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:[applications allObjects]
                                              forKey:kKSUserInfoSpecialApplicationsKey];
}

- (void)removeSpecialApplicationsObject:(NSString *)object
{
    NSMutableSet *applications = (NSMutableSet *)self.specialApplications;
    [applications removeObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:[applications allObjects]
                                              forKey:kKSUserInfoSpecialApplicationsKey];
}

- (void)setSpecialApplicationsAreBlacklist:(BOOL)specialApplicationsAreBlacklist
{
    _specialApplicationsAreBlacklist = specialApplicationsAreBlacklist;
    [[NSUserDefaults standardUserDefaults] setBool:_specialApplicationsAreBlacklist
                                            forKey:kKSUserInfoSpecialApplicationsAreBlacklistKey];
}

- (void)setURLMappings:(NSDictionary *)URLMappings
{
    _URLMappings = [URLMappings mutableCopy];
    [[NSUserDefaults standardUserDefaults] setObject:_URLMappings
                                              forKey:kKSUserInfoURLMappingsKey];
}

- (void)addOrReplaceURLMappingWithMappedName:(NSString *)mappedName forURL:(NSString *)URL;
{
    [(NSMutableDictionary *)self.URLMappings setObject:mappedName forKey:URL];
    [[NSUserDefaults standardUserDefaults] setObject:_URLMappings
                                              forKey:kKSUserInfoURLMappingsKey];
}

- (void)removeURLMappingWithURL:(NSString *)URL
{
    [(NSMutableDictionary *)self.URLMappings removeObjectForKey:URL];
    [[NSUserDefaults standardUserDefaults] setObject:_URLMappings
                                              forKey:kKSUserInfoURLMappingsKey];    
}


@end
