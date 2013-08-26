//
//  KSAppDelegate.m
//  KnowSensor X
//
//  Created by David Ganster on 14/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSAppDelegate.h"
#import "KSMainWindowController.h"

@interface KSAppDelegate ()

@property(nonatomic, strong) KSMainWindowController *mainWindowController;

@end

@implementation KSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"dg.KnowSensor_X"];
    self.mainWindowController = [[KSMainWindowController alloc] initWithWindowNibName:@"KSMainWindowController"];
    [[self.mainWindowController window] makeKeyAndOrderFront:self];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "dg.KnowSelf_X" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"dg.KnowSelf_X"];
}


- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
    return NSTerminateNow;
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}


@end
