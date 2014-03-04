//
//  KSAppDelegate.m
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "KSAppDelegate.h"
#import "KSMainWindowController.h"
#import "KSAPIClient.h"
#import "KSSensorController.h"
#import "KSUserInfo.h"

#import <ApplicationServices/ApplicationServices.h>

@interface KSAppDelegate ()

/// Strong reference to the NSTask that provides a handle to the KnowServer.
@property(nonatomic, strong) NSTask *knowServerTask;
/// Indicates if the app is already about to terminate in case 'exit:' is called twice.
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

/**
 *  Checks if accessibiliy is enabled for KnowSensor X. On 10.9, the built-in way of checking and enabling is used, 
 *  on 10.8 and below, an alert telling the user to go to the settings will be shown.
 */
- (void)checkIfAccessabilityIsEnabled
{
    BOOL accessibilityEnabled = NO;
    if([KSUtils accessibilityPopupAvailable]) {
        NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
         accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
        // 10.9 and above will display a dialog that will take the user to the System Preferences.
    } else {
        // 10.8 and below will need an extra dialog for this:
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

    [self startKnowServer];
    self.mainWindowController = [[KSMainWindowController alloc] initWithWindowNibName:@"KSMainWindowController"];
    [self.mainWindowController loadWindow]; // awakeFromNib needs to be called for the app to work.

    // has to be set the first time, so just call it here
    if([KSUtils isFirstStart]) {
        [[self.mainWindowController window] makeKeyAndOrderFront:self];
    }
    
    [[KSAPIClient sharedClient] startCheckingForServerReachability];
    
    // The very first thing to do: Check if accessibility is enabled. This is required for the Idle Sensor to work correctly!
    // If accessibility is not enabled, this will show an alert and quit the app.
    [self checkIfAccessabilityIsEnabled];

    LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"KnowSensor X started.");
}

/**
 *  Starts the KnowServer if the serverAddress saved in KSUserInfo is equal to the server base url
 *  (127.0.0.1:8182).
 *  Otherwise, this method will simply return.
 */
- (void)startKnowServer
{
    if(![[[KSUserInfo sharedUserInfo] serverAddress] isEqualToString:kKSServerBaseURL]) {
//        LogMessage(kKSLogTagOther, kKSLogLevelInfo, @"Will not start KnowServer: BaseURL is different.");
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

/**
 *  Stops the KnowServer if it is running.
 *  Waits for it to exit, so this method might take some time to return.
 */
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

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    if(![[KSAPIClient sharedClient] serverReachable]) {
        // server isn't reachable - no point in waiting forever - just quit now.
        [self stopKnowServer];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.isTerminated = YES;
        return NSTerminateNow;
    }
    
    // don't wait for reachability, just try to get the events to the server as quickly as possible:
    [[KSSensorController sharedSensorController] setWaitForReachability:NO];
    // stop all event recording for smooth shutdown
    [[KSSensorController sharedSensorController] stopRecordingEventsFinished:^(BOOL successful) {
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
