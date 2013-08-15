//
//  KSFocusEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KSFocusEvent : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * processID;
@property (nonatomic, retain) NSString * processName;
@property (nonatomic, retain) NSString * screenshotPath;
@property (nonatomic, retain) NSString * windowTitle;

@end
