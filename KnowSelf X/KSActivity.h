//
//  KSActivity.h
//  KnowSensor X
//
//  Created by David Ganster on 05/01/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"
#import "KSImportable.h"

@class KSProject;

@interface KSActivity : NSObject<KSExportable, KSImportable>

@property (nonatomic, retain) NSString * activityID;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * name;

/// @warning This property is read from the field 'project', which contains the name of the project when loading an activity, `but` the server expects the 'projectID' when sending data to the server. This is why 'isStartingRecording' is needed.
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) KSProject *project;

@end
