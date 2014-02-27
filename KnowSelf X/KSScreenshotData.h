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

/**
 *  Describes the screenshot data to be sent to the server.
 *  Mirrors the data model on the KnowServer.
 */
@interface KSScreenshotData : NSObject <KSExportable>

/// Height of the represented image in pixels.
@property (nonatomic, retain) NSNumber * heightInPixel;
/// Width of the represented image in pixels.
@property (nonatomic, retain) NSNumber * widthInPixel;
/// Image format as string, without leading '.'. (e.g. "jpg", "png" etc).
@property (nonatomic, retain) NSString * imageFormat;
/// The actual pixel data, encoded as a base64 string.
@property (nonatomic, retain) NSString * pixelDataBase64Encoded;

@end
