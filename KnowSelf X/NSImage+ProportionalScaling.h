//
//  NSImage+ProportionalScaling.h
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (ProportionalScaling)

- (NSImage*)imageByScalingProportionallyToSize:(NSSize)targetSize;
@end
