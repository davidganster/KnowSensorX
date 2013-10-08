//
//  KSAppDelegate.m
//  KnowSensor X
//
//  Created by David Ganster on 14/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSAppDelegate.h"
#import "KSMainWindowController.h"
#import "KSAPIClient.h"
#import "KSSensorController.h"
#import "STPrivilegedTask.h"

@interface KSAppDelegate ()

@property(nonatomic, strong) KSMainWindowController *mainWindowController;
@property(nonatomic, strong) NSTask *knowServerTask;
@property(nonatomic, strong) STPrivilegedTask *privilegedTask;

@end

@implementation KSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    LoggerSetOptions(LoggerGetDefaultLogger(), //kLoggerOption_LogToConsole |
                     kLoggerOption_BrowseBonjour);

    
    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Starting KnowSensor X.");
    
    // has to be set the first time, so just call it here
    BOOL firstStart = [self isFirstStart];
    if(firstStart) {
        LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"First start.");
    }
    
    [self startKnowServer];
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"dg.KnowSensor_X"];
    self.mainWindowController = [[KSMainWindowController alloc] initWithWindowNibName:@"KSMainWindowController"];
    [[self.mainWindowController window] makeKeyAndOrderFront:self];

    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"KnowSensor X started.");
}

- (BOOL)isFirstStart
{
    BOOL isFirstStart = [[NSUserDefaults standardUserDefaults] boolForKey:kKSIsFirstStartKey];
    if(!isFirstStart) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kKSIsFirstStartKey];
    }
    
    return isFirstStart;
}

- (void)startKnowServer
{
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"Starting KnowServer...");
    
    // might only need to run as admin the first time, need to test for this.
//    self.privilegedTask = [[STPrivilegedTask alloc] init];
//    [self.privilegedTask setLaunchPath:kKSKnowServerPaxRunnerPath];
//    [self.privilegedTask setArguments:kKSKnowServerPaxRunnerArgs];
//    [self.privilegedTask launch];
    

    // TODO: this is the old code without elevated privileges. remove if unnecessary.
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"%@", kKSKnowServerRelativePaxRunnerPath);
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"%@", kKSKnowServerRelativePaxRunnerArgs);
    
    self.knowServerTask = [[NSTask alloc] init];
    [self.knowServerTask setLaunchPath:kKSKnowServerRelativePaxRunnerPath];
    [self.knowServerTask setArguments:kKSKnowServerRelativePaxRunnerArgs];
    [self.knowServerTask setStandardInput:[NSPipe pipe]];
//    [self.knowServerTask setStandardOutput:nil];
    [self.knowServerTask launch];
    
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer started.");
}

- (void)stopKnowServer
{
    
//    [self.privilegedTask.outputFileHandle writeData:[kKSKnowServerCommandCloseServer dataUsingEncoding:NSUTF8StringEncoding]];
//    [self.privilegedTask.outputFileHandle closeFile];
//    [self.privilegedTask waitUntilExit];
    
    // TODO: this is the old code without elevated privileges. remove if unnecessary.
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
    // stop all event recording for smooth shutdown
    // important: do this /before/ cleaning up MagicalRecord! (otherwise the defaultContext will be gone)
    // TODO: make this work with the server.
//    [[KSSensorController sharedSensorController] stopRecordingEvents];

    // Save changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
    
    
    // tear down KnowServer as well
    if([self.knowServerTask isRunning]  || [self.privilegedTask isRunning])
        [self stopKnowServer];
    
    return NSTerminateNow;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if([self.knowServerTask isRunning] || [self.privilegedTask isRunning]) {
        [self stopKnowServer];
    }
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}

@end
