//
//  KSMainWindowController.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSSensor.h"
#import "KSProjectController.h"

/**
 * This class manages the main window of the program. No logic being done here.
 */
@interface KSMainWindowController : NSWindowController<NSTabViewDelegate, KSProjectControllerEventObserver>

@end
