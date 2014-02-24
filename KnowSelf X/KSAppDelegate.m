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
#import "KSUserInfo.h"

#import <ApplicationServices/ApplicationServices.h>

@interface KSAppDelegate ()

@property(nonatomic, strong) NSTask *knowServerTask;
@property(nonatomic, assign) BOOL isTerminated;

@end

@implementation KSAppDelegate

static pid_t taskPID;

void HandleExceptions(NSException *exception)
{
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"Uncaught exception raised: %@", exception);
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"I won't go alone!1!!!1! Killing KnowServer as well.");
    [[NSUserDefaults standardUserDefaults] synchronize];
    kill(taskPID, SIGKILL);
}

void SignalHandler(int sig)
{
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"KILLED BY SIGNAL: %i", sig);
    LogMessage(kKSLogTagOther, kKSLogLevelError, @"I won't go alone!1!!!1! Killing KnowServer as well.");
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    self.isTerminated = NO;
    
    // installs HandleExceptions as the Uncaught Exception Handler (as well as SignalHandler)
    NSSetUncaughtExceptionHandler(&HandleExceptions);
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0, sizeof(newSignalAction));
    newSignalAction.sa_handler = &SignalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
//    sigaction(SIGKILL, &newSignalAction, NULL); // cannot be caught... The server will keep running in that case :(

//    LoggerSetOptions(LoggerGetDefaultLogger(), //kLoggerOption_LogToConsole |
//                     kLoggerOption_BrowseBonjour);
    
    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Starting KnowSensor X.");
    [self startKnowServer];
    self.mainWindowController = [[KSMainWindowController alloc] initWithWindowNibName:@"KSMainWindowController"];
    [self.mainWindowController loadWindow]; // awakeFromNib needs to be called for the app to work.
    // has to be set the first time, so just call it here
    if([KSUtils isFirstStart]) {
        LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"First start.");
        [[self.mainWindowController window] makeKeyAndOrderFront:self];
    }
    
    [[KSAPIClient sharedClient] startCheckingForServerReachability];
    
    // The very first thing to do: Check if accessibility is enabled. This is required for the Idle Sensor to work correctly!
    // If accessibility is not enabled, this will show an alert and quit the app.
    [self checkIfAccessabilityIsEnabled];

    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"KnowSensor X started.");
}

- (void)startKnowServer
{
    if(![[[KSUserInfo sharedUserInfo] serverAddress] isEqualToString:kKSServerBaseURL]) {
        LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Will not start KnowServer: BaseURL is different.");
        return;
    }
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
    // don't wait for reachability, just try to get the events to the server as quickly as possible:
    [[KSSensorController sharedSensorController] setWaitForReachability:NO];
    // stop all event recording for smooth shutdown
    [[KSSensorController sharedSensorController] stopRecordingEventsFinished:^(BOOL successful) {
        // since we never save anything persistently, this doesn't seem very useful:
        //    [MagicalRecord cleanUp];

        // tear down KnowServer as well
        [self stopKnowServer];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.isTerminated = YES;
        
        // TODO: check if stopping actually worked and warn user if it didn't.
        [NSApp replyToApplicationShouldTerminate:YES];
    }];

    return NSTerminateLater;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if(!self.isTerminated) {
        [self applicationShouldTerminate:nil];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}

@end
