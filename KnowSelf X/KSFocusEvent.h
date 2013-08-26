//
//  KSFocusEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 25/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"


@interface KSFocusEvent : KSEvent

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * processID;
@property (nonatomic, retain) NSString * processName;
@property (nonatomic, retain) NSString * screenshotPath;
@property (nonatomic, retain) NSString * windowTitle;
@property (nonatomic, retain) NSString * windowhandle;
@property (nonatomic, retain) NSString * runtimeID;

@end
