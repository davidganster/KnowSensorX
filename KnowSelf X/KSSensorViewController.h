//
//  KSSensorViewController.h
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSSensor.h"

@interface KSSensorViewController : NSViewController<KSSensorDelegateProtocol, NSTableViewDataSource, NSTableViewDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate>

@property(nonatomic, strong) NSArray *sensors;

@property (weak) IBOutlet NSTableView *sensorsTableView;
@property (weak) IBOutlet NSOutlineView *sensorStatusMessageOutlineView;
@end
