//
//  KSIdleEvent.h
//  KnowSensor X
//
//  Created by David Ganster on 18/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSEvent.h"


@interface KSIdleEvent : KSEvent

@property (nonatomic, retain) NSNumber * idleSinceSeconds;
@property (nonatomic, retain) NSDate * idleSinceTimestamp;
@property (nonatomic, retain) NSDate * timeOfRecording;

@end
