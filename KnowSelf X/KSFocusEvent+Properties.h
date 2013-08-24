//
//  KSFocusEvent+Properties.h
//  KnowSensor X
//
//  Created by David Ganster on 24/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusEvent.h"

/// Properties in this category are not going to be stored by CoreData.
/// This is useful for things like the screenshot images, which would take up a lot of space on the HD after a while.
@interface KSFocusEvent (Properties)

@property(nonatomic, retain) NSImage *screenshot;

@end
