//
//  KSProject.h
//  KnowSensor X
//
//  Created by David Ganster on 26/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KSActivity;

@interface KSProject : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * projectID;
@property (nonatomic, retain) NSSet *activities;
@end

@interface KSProject (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(KSActivity *)value;
- (void)removeActivitiesObject:(KSActivity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end
