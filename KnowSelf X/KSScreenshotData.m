//
//  KSScreenshotData.m
//  KnowSensor X
//
//  Created by David Ganster on 21/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSScreenshotData.h"
#import "KSFocusEvent.h"


@implementation KSScreenshotData

- (NSDictionary *)dictRepresentation
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.heightInPixel forKey:@"heightInPixel"];
    [dataDict setObject:self.widthInPixel forKey:@"widthInPixel"];
    [dataDict setObject:self.imageFormat forKey:@"imageFormat"];
    [dataDict setObject:self.pixelDataBase64Encoded forKey:@"pixelDataBase64Encoded"];
    return dataDict;
}

@end
