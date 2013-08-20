//
//  KSUserInfo.m
//  KnowSensor X
//
//  Created by David Ganster on 20/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSUserInfo.h"

@implementation KSUserInfo

+(KSUserInfo *)sharedUserInfo
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
        self.deviceID = @"TODO SAVE DEVICE ID IN USER DEFAULTS";
        self.userID = @"TODO SAVE USER ID IN USER DEFAULTS";
    }
    return self;
}


@end
