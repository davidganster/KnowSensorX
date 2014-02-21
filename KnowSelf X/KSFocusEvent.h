//
//  KSFocusEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"

@class KSScreenshotData;

@interface KSFocusEvent : KSEvent

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * processID;
@property (nonatomic, retain) NSString * processName;
@property (nonatomic, retain) NSString * runtimeID;
@property (nonatomic, retain) NSString * windowhandle;
@property (nonatomic, retain) NSString * windowTitle;
@property (nonatomic, retain) KSScreenshotData *screenshot;

@end
