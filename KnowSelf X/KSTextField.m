//
//  KSTextField.m
//  KnowSensor X
//
//  Created by David Ganster on 23/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSTextField.h"

@implementation KSTextField

/**
 *  Calls `[super setEnabled]` and then adjusts the receiver's text color depending on the value of `flag`.
 *
 *  @param flag Controls the text color. `YES` stands for controlTextColor, `NO` means using the disabledControlTextColor.
 */
- (void)setEnabled:(BOOL)flag
{
    [super setEnabled:flag];
    if(flag ) {
        [self setTextColor:[NSColor controlTextColor]];
    } else {
        [self setTextColor:[NSColor disabledControlTextColor]];
    }
}

@end
