//
//  KSActivity.h
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KSProject;

@interface KSActivity : NSManagedObject

@property (nonatomic, retain) NSString * activityID;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) KSProject *project;

@end
