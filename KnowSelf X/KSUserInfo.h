//
//  KSUserInfo.h
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class provides access to all settings and information entered by the user.
 *  This includes general information such as the user's name and device ID, but also 
 *  more specific data such as URL mappings and black/whitelists.
 */
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
/// @note Use the 'add-/removeSpecialApplicationsObject:' methods to modify the set.
@property(nonatomic, strong) NSSet *specialApplications;

/// Determines whether the 'specialApplications' are treated as a black- or whitelist.
/// Defaults to YES.
@property(nonatomic, assign) BOOL specialApplicationsAreBlacklist;

/// Maps from NSString (the URL to map) to NSString (the displayed name on the server)
/// The keys (URLs) will be matched (using a regular expression) against the URLs retrieved from browsers.
/// The corresponding values (names) are the names that will be displayed in the Web Application.
/// Readonly.
@property(nonatomic, strong) NSDictionary *URLMappings;

/// The minimum idle time in seconds before an idle event is registered.
/// Changing this value will emitt a notification with the key 'kKSNotificationKeyIdleTimeChanged'.
/// The userInfo dictionary contained in the generated notification contains
/// the new idle time for the key 'kKSNotificationUserInfoKeyNewIdleTime'
@property(nonatomic, assign) CGFloat minimumIdleTime;

/// Indicated whether or not screenshots should recorded and sent along focus-change events.
/// Defaults to YES.
@property(nonatomic, assign) BOOL shouldRecordScreenshots;

/// Quality with which to record (= scale) screenshots.
/// Defaults to kKSScreenshotQualityMedium.
@property(nonatomic, assign) KSScreenshotQuality screenshotQuality;

/**
 *  Returns the shared KSUserInfo object for retrieving/setting global user infos.
 *
 *  @return The singleton object.
 */
+ (KSUserInfo *)sharedUserInfo;

/**
 *  Resets every value stored in KSUserInfo to its default value.
 */
- (void)resetToDefaults;

/**
 *  Saves all values in KSUserInfo to the given path as a plist file.
 *
 *  @param path Absolute path (including filename) where the file should be saved.
 *  @param includeUserData If YES, the backup will also include personal data such as the user's name and deviceID.
 *  @return YES if the file could be saved, else NO.
 */
- (BOOL)saveUserInfoToPath:(NSURL *)path includeUserData:(BOOL)includeUserData;

/**
 *  Loads all values in KSUserInfo from the given path to a plist file.
 *  Nil values are ignored and left as they are.
 *  This makes it possible to exclude certain attributes from import/export.
 *  After loading is finished, a 'kKSNotificationUserInfoDidImport' notification will be emitted.
 *
 *  @param path Absolute path to the plist file to be loaded.
 *  @return YES if the file could be loaded, else NO.
 */
- (BOOL)loadUserInfoFromPath:(NSURL *)path;

/**
 *  Adds an object to the `specialApplications` set.
 *  This is the preferred way to add objects (as opposed to newly setting the set).
 *
 *  @param object The absolute string pointing to the application's bundle.
 */
- (void)addSpecialApplicationsObject:(NSString *)object;

/**
 *  Removes an object from the `specialApplications` set.
 *  This is the preferred way to remove objects (as opposed to newly setting the set).
 *
 *  @param object The absolute string pointing to the application's bundle.
 */
- (void)removeSpecialApplicationsObject:(NSString *)object;


/**
 *  Sets the `mappedName` for the `URL` in the URLMappings dictionary.
 *  This is the preferred way to add mappings (as opposed to newly setting the dictionary).
 *
 *  @param mappedName The name that will replace the URL.
 *  @param URL        The URL to be replaced.
 */
- (void)addOrReplaceURLMappingWithMappedName:(NSString *)mappedName forURL:(NSString *)URL;

/**
 *  Removes an object from the `URLMappings` dictionary.
 *  This is the preferred way to remove objects (as opposed to newly setting the dictionary).
 *
 *  @param object The URL for which the mapping should be removed.
 */
- (void)removeURLMappingWithURL:(NSString *)URL;

@end
