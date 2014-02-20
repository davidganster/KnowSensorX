//
//  KSFocusEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"


@interface KSFocusEvent : KSEvent

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * processID;
@property (nonatomic, retain) NSString * processName;
@property (nonatomic, retain) NSString * runtimeID;
@property (nonatomic, retain) NSData * screenshot;
@property (nonatomic, retain) NSString * windowhandle;
@property (nonatomic, retain) NSString * windowTitle;

@end
