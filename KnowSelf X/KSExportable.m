//
//  KSExportable.m
//  KnowSensor X
//
//  Created by David Ganster on 22/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSExportable.h"

@implementation KSExportable

- (NSDictionary *)dictRepresentation
{
    NSAssert(FALSE, @"Must overwrite in subclass.");
    return nil;
}

@end
