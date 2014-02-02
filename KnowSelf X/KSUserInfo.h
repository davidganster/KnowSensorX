//
//  KSUserInfo.h
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUserInfo : NSObject

/// The identifier of the current computer.
/// Defaults to 'SCDynamicStoreCopyComputerName()'.
@property(nonatomic, strong) NSString *deviceID;

/// The name of the current user.
/// Defaults to the return-value of 'NSFullUserName()' and can be set by the user in the settings.
@property(nonatomic, strong) NSString *userID;

/// The server address to use when contacting a server.
/// Defaults to 127.0.0.1:8182.
@property(nonatomic, strong) NSString *serverAddress;

/// A set of NSStrings (application paths) that can be treated as a white- or blacklist.
/// Defaults to an empty set.
@property(nonatomic, strong) NSSet *specialApplications;

/// Determines whether the 'specialApplications' are treated as a black- or whitelist.
/// Defaults to YES.
@property(nonatomic, assign) BOOL specialApplicationsAreBlacklist;

/// Returns the singleton for retrieving/setting global user infos.
+ (KSUserInfo *)sharedUserInfo;

/// Resets every stored user info to its default value.
/// That includes: 'deviceID', 'userID', 'serverAddress', 'specialApplications' and 'treatSpecialApplicationsAsBlackList'
- (void)resetToDefaults;

// Methods to modify the 'specialApplications' set.
- (void)addSpecialApplicationsObject:(NSURL *)object;
- (void)removeSpecialApplicationsObject:(NSURL *)object;

@end
