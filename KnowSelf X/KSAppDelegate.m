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
@property(nonatomic, strong) NSTask *knowServerTask;

@end

@implementation KSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"dg.KnowSensor_X"];
    self.mainWindowController = [[KSMainWindowController alloc] initWithWindowNibName:@"KSMainWindowController"];
    [[self.mainWindowController window] makeKeyAndOrderFront:self];
    
    LoggerSetOptions(LoggerGetDefaultLogger(), kLoggerOption_LogToConsole |
                                               kLoggerOption_BrowseBonjour);
    
    [self startKnowServer];
}


- (void)startKnowServer
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Starting KnowServer...");
    
    self.knowServerTask = [[NSTask alloc] init];
    NSPipe *inputPipe = [NSPipe pipe];
    [self.knowServerTask setLaunchPath:kKSKnowServerPaxRunnerPath];
    [self.knowServerTask setArguments:kKSKnowServerPaxRunnerArgs];
    [self.knowServerTask setStandardInput:inputPipe];
    [self.knowServerTask setStandardOutput:nil];
    [self.knowServerTask launch];
    
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer started.");
}

- (void)stopKnowServer
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Stopping KnowServer...");
    NSFileHandle *writeHandle = [self.knowServerTask.standardInput fileHandleForWriting];
    
    NSData *queryBytes = [kKSKnowServerCommandCloseServer dataUsingEncoding:NSUTF8StringEncoding];
    [writeHandle writeData: queryBytes];
    [self.knowServerTask waitUntilExit];
    
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer stopped.");
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
    
    // tear down KnowServer as well
    if([self.knowServerTask isRunning])
        [self stopKnowServer];
    
    return NSTerminateNow;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if([self.knowServerTask isRunning]) {
        [self stopKnowServer];
    }
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}


@end
