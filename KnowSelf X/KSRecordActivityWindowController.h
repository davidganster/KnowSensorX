//
//  KSRecordActivityWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 28/12/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSProjectController.h"

@interface KSRecordActivityWindowController : NSWindowController<NSComboBoxDataSource, NSComboBoxDelegate, KSProjectControllerEventObserver, NSAlertDelegate>

- (id)initWithProject:(KSProject *)project activity:(KSActivity *)activity;
@end
