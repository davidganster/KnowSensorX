//
//  KSTextField.m
//  KnowSensor X
//
//  Created by David Ganster on 23/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSTextField.h"

@implementation KSTextField

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
