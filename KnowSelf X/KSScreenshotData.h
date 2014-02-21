//
//  KSScreenshotData.h
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KSFocusEvent;

@interface KSScreenshotData : NSManagedObject

@property (nonatomic, retain) NSNumber * heightInPixel;
@property (nonatomic, retain) NSString * imageFormat;
@property (nonatomic, retain) NSString * pixelDataBase64Encoded;
@property (nonatomic, retain) NSNumber * widthInPixel;
@property (nonatomic, retain) KSFocusEvent *focusEvent;

@end
