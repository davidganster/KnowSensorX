//
//  KSAppDelegate.h
//  KnowSensor X
//
//  Created by David Ganster on 14/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KSMainWindowController;

@interface KSAppDelegate : NSObject <NSApplicationDelegate>

@property(nonatomic, strong) KSMainWindowController *mainWindowController;

@end
