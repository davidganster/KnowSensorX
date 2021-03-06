//
//  KSUserInfo.m
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "KSUserInfo.h"

@implementation KSUserInfo

- (id)init
{
    self = [super init];
    if(self) {
        [self loadValuesFromUserDefaults];
    }
    return self;
}

/**
 *  Loads all properties from the standardUserDefaults, or sets them to the default values if
 *  no entry for them is found.
 */
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
    
    _shouldRecordScreenshots = [[NSUserDefaults standardUserDefaults] boolForKey:kKSUserInfoShouldRecordScreenshotsKey];
    
    _screenshotQuality = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kKSUserInfoScreenshotQualityKey];

    if([KSUtils isFirstStart]) {
        self.specialApplicationsAreBlacklist = YES;
        self.shouldRecordScreenshots = YES;
        self.screenshotQuality = KSScreenshotQualityMedium;
    }
    
    _URLMappings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kKSUserInfoURLMappingsKey] mutableCopy];
    if(!_URLMappings) {
        _URLMappings = [@{@"127.0.0.1:8182" : @"KnowSelf WebApp",
                          @"http://127.0.0.1:8182/?showobservations=1" : @"KnowSelf Diary",
                          @"www.google.*" : @"Google"} mutableCopy];
    }
    
    _minimumIdleTime = [[NSUserDefaults standardUserDefaults] floatForKey:kKSUserInfoMinimumIdleTimeKey];
    if(_minimumIdleTime < 1) {
        _minimumIdleTime = kKSIdleSensorMinimumIdleTime;
    }
}

#pragma mark - Public methods
/// @name Public methods

+ (KSUserInfo *)sharedUserInfo
{
    static KSUserInfo *_sharedUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUserInfo = [[KSUserInfo alloc] init];
    });
    
    return _sharedUserInfo;
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
    self.shouldRecordScreenshots = YES;
    self.minimumIdleTime = kKSIdleSensorMinimumIdleTime;
    self.screenshotQuality = KSScreenshotQualityMedium;
}

- (BOOL)saveUserInfoToPath:(NSURL *)path includeUserData:(BOOL)includeUserData
{
    // build a dictionary with all values, then save it to the specified path
    NSMutableDictionary *dictionary = [@{kKSUserInfoDeviceNameKey : self.deviceID,
                                         kKSUserInfoServerAddressKey : self.serverAddress,
                                         kKSUserInfoUserNameKey : self.userID,
                                         kKSUserInfoMinimumIdleTimeKey : @(self.minimumIdleTime),
                                         kKSUserInfoSpecialApplicationsAreBlacklistKey : @(self.specialApplicationsAreBlacklist),
                                         kKSUserInfoShouldRecordScreenshotsKey : @(self.shouldRecordScreenshots),
                                         kKSUserInfoScreenshotQualityKey :@(self.screenshotQuality),
                                         kKSUserInfoSpecialApplicationsKey : [self.specialApplications allObjects],
                                         kKSUserInfoURLMappingsKey : self.URLMappings} mutableCopy];
    
    if(!includeUserData) {
        [dictionary removeObjectsForKeys:@[kKSUserInfoDeviceNameKey, kKSUserInfoUserNameKey]];
    }
    
    if([dictionary writeToURL:path atomically:YES])
        return YES;
    return NO;
}

- (BOOL)loadUserInfoFromPath:(NSURL *)path
{
    // get the dictionary from the given plist, then update all properties
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:path];
    if(dictionary) {
        // only overwrite non-nil objects!
        NSString *userID = dictionary[kKSUserInfoUserNameKey];
        if(userID) self.userID = userID;
        
        NSString *serverAddress = dictionary[kKSUserInfoServerAddressKey];
        if(serverAddress) self.serverAddress = serverAddress;
        
        NSString *deviceName = dictionary[kKSUserInfoDeviceNameKey];
        if(deviceName) self.deviceID = deviceName;
        
        NSNumber *minimumIdleTime = dictionary[kKSUserInfoMinimumIdleTimeKey];
        if(minimumIdleTime) self.minimumIdleTime = [minimumIdleTime floatValue];
        
        NSNumber *isBlacklist = dictionary[kKSUserInfoSpecialApplicationsAreBlacklistKey];
        if(isBlacklist) self.specialApplicationsAreBlacklist = [isBlacklist boolValue];
        
        NSArray *specialApps = dictionary[kKSUserInfoSpecialApplicationsKey];
        if(specialApps) self.specialApplications = [NSMutableSet setWithArray:specialApps];
        
        NSDictionary *URLMappings = dictionary[kKSUserInfoURLMappingsKey];
        if(URLMappings) self.URLMappings = URLMappings;
        
        NSNumber *shouldRecordScreenshots = dictionary[kKSUserInfoShouldRecordScreenshotsKey];
        if(shouldRecordScreenshots) self.shouldRecordScreenshots = [shouldRecordScreenshots boolValue];
        
        NSNumber *screenshotQuality = dictionary[kKSUserInfoScreenshotQualityKey];
        if(screenshotQuality) self.screenshotQuality = [screenshotQuality integerValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationUserInfoDidImport
                                                            object:nil];
        return YES;
    } else {
        return NO;
    }
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


- (void)setMinimumIdleTime:(CGFloat)minimumIdleTime
{
    _minimumIdleTime = minimumIdleTime;
    [[NSUserDefaults standardUserDefaults] setFloat:_minimumIdleTime
                                             forKey:kKSUserInfoMinimumIdleTimeKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyIdleTimeChanged
                                                        object:nil
                                                      userInfo:@{kKSNotificationUserInfoKeyNewIdleTime:@(minimumIdleTime)}];
}

- (void)setShouldRecordScreenshots:(BOOL)shouldRecordScreenshots
{
    _shouldRecordScreenshots = shouldRecordScreenshots;
    [[NSUserDefaults standardUserDefaults] setBool:_shouldRecordScreenshots
                                            forKey:kKSUserInfoShouldRecordScreenshotsKey];
}

- (void)setScreenshotQuality:(KSScreenshotQuality)screenshotQuality
{
    _screenshotQuality = screenshotQuality;
    [[NSUserDefaults standardUserDefaults] setInteger:_screenshotQuality
                                               forKey:kKSUserInfoScreenshotQualityKey];
}

@end
