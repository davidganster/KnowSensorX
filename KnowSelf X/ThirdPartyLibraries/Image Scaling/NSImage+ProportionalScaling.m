//
//  NSImage+ProportionalScaling.m
//  KnowSensor X
//
//  Created by David Ganster on 20/02/14.
//  This is a copy of the code from here:
//  http://theocacao.com/document.page/498/
//

#import "NSImage+ProportionalScaling.h"

@implementation NSImage (ProportionalScaling)

- (NSImage*)imageByScalingProportionallyToSize:(NSSize)targetSize {
    NSImage* sourceImage = self;
    NSImage* newImage = nil;
    
    // minor optimization for scale==1
    if(CGSizeEqualToSize(targetSize, self.size))
        return [self copy];
    
    if ([sourceImage isValid]){
        NSSize imageSize = [sourceImage size];
        float width  = imageSize.width;
        float height = imageSize.height;
        
        float targetWidth  = targetSize.width;
        float targetHeight = targetSize.height;
        
        float scaleFactor  = 0.0;
        float scaledWidth  = targetWidth;
        float scaledHeight = targetHeight;
        
        NSPoint thumbnailPoint = NSZeroPoint;
        
        if ( NSEqualSizes( imageSize, targetSize ) == NO )
        {
            
            float widthFactor  = targetWidth / width;
            float heightFactor = targetHeight / height;
            
            if ( widthFactor < heightFactor )
                scaleFactor = widthFactor;
            else
                scaleFactor = heightFactor;
            
            scaledWidth  = width  * scaleFactor;
            scaledHeight = height * scaleFactor;
            
            if ( widthFactor < heightFactor )
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
            else if ( widthFactor > heightFactor )
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        newImage = [[NSImage alloc] initWithSize:targetSize];
        [newImage lockFocus];
        NSRect thumbnailRect;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect: thumbnailRect
                       fromRect: NSZeroRect
                      operation: NSCompositeSourceOver
                       fraction: 1.0];
        [newImage unlockFocus];
    }
    return newImage;
}
@end
