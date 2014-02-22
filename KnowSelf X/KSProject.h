//
//  KSProject.h
//  KnowSensor X
//
//  Created by David Ganster on 24/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"
#import "KSImportable.h"

@class KSActivity;

@interface KSProject : NSObject<KSExportable, KSImportable>

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * projectID;
@property (nonatomic, retain) NSOrderedSet *activities;
@end

@interface KSProject (CoreDataGeneratedAccessors)

- (void)insertObject:(KSActivity *)value inActivitiesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromActivitiesAtIndex:(NSUInteger)idx;
- (void)insertActivities:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeActivitiesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInActivitiesAtIndex:(NSUInteger)idx withObject:(KSActivity *)value;
- (void)replaceActivitiesAtIndexes:(NSIndexSet *)indexes withActivities:(NSArray *)values;
- (void)addActivitiesObject:(KSActivity *)value;
- (void)removeActivitiesObject:(KSActivity *)value;
- (void)addActivities:(NSOrderedSet *)values;
- (void)removeActivities:(NSOrderedSet *)values;
@end
