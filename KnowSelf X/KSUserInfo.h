//
//  KSUserInfo.h
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUserInfo : NSObject

@property(nonatomic, strong) NSString *deviceID;
@property(nonatomic, strong) NSString *userID;
@property(nonatomic, strong) NSString *serverAddress;

+ (KSUserInfo *)sharedUserInfo;
- (void)resetToDefaults;

@end
