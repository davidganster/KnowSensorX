//
//  KSIdleEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KSIdleEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * idleSinceSeconds;
@property (nonatomic, retain) NSDate * idleSinceTimestamp;

@end
