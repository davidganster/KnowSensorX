//
//  NSColor+HexParsing.h
//  KnowSensor X
//
//  Created by David Ganster on 28/12/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (HexParsing)

+ (NSColor*)colorWithHexColorString:(NSString*)inColorString;

@end
