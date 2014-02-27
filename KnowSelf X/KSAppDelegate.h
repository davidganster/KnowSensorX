//
//  KSAppDelegate.h
//  KnowSensor X
//
//  Created by David Ganster on 14/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KSMainWindowController;

/**
 *  Application delegate. 
 *  Handles launching and stopping the KnowServer task, as well as
 *  asking for accessibility access and handling uncaught exceptions.
 *  When an `applicationShouldTerminate:` message is received, the delegate will tell
 *  the `KSSensorController` to stop recording events, reply wth `NSTerminateLater`,
 *  and postpone shutdown until the KSSensorController is done stopping the recording.
 */
@interface KSAppDelegate : NSObject <NSApplicationDelegate>

@property(nonatomic, strong) KSMainWindowController *mainWindowController;

@end
