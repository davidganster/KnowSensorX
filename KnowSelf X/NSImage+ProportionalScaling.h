//
//  NSImage+ProportionalScaling.h
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (ProportionalScaling)

/**
 *  Scales the receiver to the given targetSize. 
 *  Returns a copy of itself if the size matches self.size.
 *
 *  @param targetSize The new size for the scaled image.
 *
 *  @return A new NSImage object with the same content as self, but scaled to targetSize.
 */
- (NSImage *)imageByScalingProportionallyToSize:(NSSize)targetSize;

@end
