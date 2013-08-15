//
//  KSEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KSEvent : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * type;

@end
