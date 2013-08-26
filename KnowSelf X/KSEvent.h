//
//  KSEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 26/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent_InternalWithAdditionalMethods.h"


@interface KSEvent : KSEvent_InternalWithAdditionalMethods

@property (nonatomic, retain) NSString * sensorID;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic) uint16 type;

@end
