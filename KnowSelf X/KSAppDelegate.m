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

#import <ApplicationServices/ApplicationServices.h>

@interface KSAppDelegate ()

@property(nonatomic, strong) KSMainWindowController *mainWindowController;
@property(nonatomic, strong) NSTask *knowServerTask;

@end

@implementation KSAppDelegate

static pid_t taskPID;

void HandleExceptions(NSException *exception)
{
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"Uncaught exception raised: %@", exception);
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"I won't go alone!1!!!1! Killing KnowServer as well.");
    kill(taskPID, SIGKILL);
}

void SignalHandler(int sig)
{
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"KILLED BY SIGNAL: %i", sig);
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"I won't go alone!1!!!1! Killing KnowServer as well.");
    kill(taskPID, SIGKILL);
}

- (void)checkIfAccessabilityIsEnabled
{
//    AXAPIEnabled();
//    NSDictionary *options = @{(id)kAXTrustedCheckOptionPrompt: @YES};
//    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((CFDictionaryRef)options);
    BOOL accessibilityEnabled = NO;
    if([KSUtils accessibilityPopupAvailable]) {
        NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
         accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
        // 10.9 and above will display a dialog that will take the user to the System Preferences.
        // 10.8 and below will need an extra dialog for this:
    } else {
        accessibilityEnabled = AXAPIEnabled();
        if(!accessibilityEnabled) {
            NSAlert *alert = [NSAlert alertWithMessageText:nil
                                             defaultButton:nil
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"Accessability must be enabled for this application to work correctly! Please enable it in 'System Preferences -> Security & Privacy -> Privacy -> Accessibility -> KnowSensor X', then restart the application."];
            [alert beginSheetModalForWindow:[self.mainWindowController window]
                          completionHandler:^(NSModalResponse returnCode) {
                              [[NSApplication sharedApplication] terminate:self];
                          }];
        }
    }
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // The very first thing to do: Check if accessibility is enabled. This is required for the Idle Sensor to work correctly!
    [self checkIfAccessabilityIsEnabled];

    // installs HandleExceptions as the Uncaught Exception Handler (as well as SignalHandler)
    NSSetUncaughtExceptionHandler(&HandleExceptions);
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0, sizeof(newSignalAction));
    newSignalAction.sa_handler = &SignalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGKILL, &newSignalAction, NULL); // cannot be caught?

    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"dg.KnowSensor_X"];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];

//    LoggerSetOptions(LoggerGetDefaultLogger(), //kLoggerOption_LogToConsole |
//                     kLoggerOption_BrowseBonjour);

    
    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Starting KnowSensor X.");
    
    // has to be set the first time, so just call it here
    BOOL firstStart = [self isFirstStart];
    if(firstStart) {
        LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"First start.");
    }
    
    [self startKnowServer];
    
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
    
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer Base URL: %@", kKSKnowServerRelativeBasePath);
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer runner path: %@", kKSKnowServerRelativePaxRunnerPath);
    
    self.knowServerTask = [[NSTask alloc] init];
    [self.knowServerTask setLaunchPath:@"/bin/sh"];
    [self.knowServerTask setArguments:@[[kKSKnowServerRelativeBasePath stringByAppendingString:@"startKnowServer.sh"]]];
    [self.knowServerTask setStandardInput:[NSPipe pipe]];
//    [self.knowServerTask setStandardOutput:nil];
    [self.knowServerTask launch];
    
    taskPID = self.knowServerTask.processIdentifier;
    
    LogMessage(kKSLogTagOther, kKSLogLevelDebug, @"KnowServer started.");
}

- (void)stopKnowServer
{
    if(!self.knowServerTask.isRunning) return;
    
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
    // TODO: add finishedBlock and call [NSApp replyToApplicationShouldTerminate:YES];
//    [[KSSensorController sharedSensorController] stopRecordingEvents];

    [MagicalRecord cleanUp];    
    
    // tear down KnowServer as well
    [self stopKnowServer];
    
    //[NSApp replyToApplicationShouldTerminate:YES];
    return NSTerminateNow; // NSTerminateLater
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [self stopKnowServer];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}

@end
