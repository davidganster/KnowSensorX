//
//  KSSettingsViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSettingsViewController.h"

@interface KSSettingsViewController ()

@end

@implementation KSSettingsViewController

- (id)init
{
    self = [super initWithNibName:@"KSSettingsViewController" bundle:nil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:[[NSColor redColor] CGColor]]; //RGB plus Alpha Channel
    [self.view setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self.view setLayer:viewLayer];

    CALayer *viewLayer2 = [CALayer layer];
    [viewLayer2 setBackgroundColor:[[NSColor blueColor] CGColor]]; //RGB plus Alpha Channel
    [self.hackToFixIB setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self.hackToFixIB setLayer:viewLayer2];
}

@end
