//
//  KSScreenshotData.h
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"

@class KSFocusEvent;

@interface KSScreenshotData :NSObject <KSExportable>

@property (nonatomic, retain) NSNumber * heightInPixel;
@property (nonatomic, retain) NSString * imageFormat;
@property (nonatomic, retain) NSString * pixelDataBase64Encoded;
@property (nonatomic, retain) NSNumber * widthInPixel;

@end
