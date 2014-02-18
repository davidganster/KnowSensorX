//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSFocusEvent+Addons.h"
#import "KSUserInfo.h"


@interface KSFocusSensor ()

@property(nonatomic, strong) NSRunningApplication *previousApplication;
@property(nonatomic, strong) NSString *previousFileOrUrl;
@property(nonatomic, strong) NSString *previousWindowTitle;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) dispatch_queue_t applescriptQueue;

@end

@implementation KSFocusSensor

@dynamic sensorID;
@dynamic name;

/// Common initializer. Also sets the 'sensorID' and 'name' properties of the receiver.
-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        _sensorID = kKSSensorIDFocusSensor;
        _name = kKSSensorNameFocusSensor;
        _applescriptQueue = dispatch_queue_create("com.kc.KnowSensorX.ASQueue", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_unregisterForEvents) // will send didLoseFocus event
                                                     name:kKSNotificationKeyUserIdleStart
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_registerForEvents) // will start sending events
                                                     name:kKSNotificationKeyUserIdleEnd
                                                   object:nil];
    }
    return self;
}

#pragma mark Event Handling

- (void)handleTimerFired:(id)sender
{
    dispatch_async(self.applescriptQueue, ^{
        NSRunningApplication *frontApp = [[NSWorkspace sharedWorkspace] frontmostApplication];
        BOOL isURL = NO;
        NSString *fileOrUrl = [self urlOrFileOfApplication:frontApp isURL:&isURL];

        NSString *windowTitle = [self windowTitleOfApplication:frontApp];
        if(self.previousApplication.processIdentifier == frontApp.processIdentifier &&
           ([self.previousFileOrUrl isEqualToString:fileOrUrl] || self.previousFileOrUrl == fileOrUrl)) {
            // nothing has changed since the last poll
            return;
        }
        
        KSFocusEvent *loseFocusEvent = nil;
        if(self.previousApplication && [self shouldRecordApplication:self.previousApplication]) {
            if([self isBrowser:self.previousApplication]) {
                if(self.previousFileOrUrl &&
                   self.focusDelegate &&
                   [self.focusDelegate respondsToSelector:@selector(focusSensor:mappedNameForURL:)]) {
                    self.previousFileOrUrl = [self.focusDelegate focusSensor:self
                                                            mappedNameForURL:self.previousFileOrUrl];
                }
            }
            loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                                  withFileUrl:self.previousFileOrUrl
                                                  windowTitle:self.previousWindowTitle
                                                         type:KSEventTypeDidLoseFocus];
        } else {
//            if(self.previousApplication) {
//                LogMessage(kKSLogTagFocusSensor, kKSLogLevelDebug, @"Will not stop recording application: %@", self.previousApplication.localizedName);
//            }
        }
        
        self.previousApplication = frontApp;
        self.previousFileOrUrl = fileOrUrl;
        self.previousWindowTitle = windowTitle;
        
        
        KSFocusEvent *currentEvent = nil;
        if([self shouldRecordApplication:frontApp]) {
            if(isURL) {
                if(fileOrUrl &&
                   self.focusDelegate &&
                   [self.focusDelegate respondsToSelector:@selector(focusSensor:mappedNameForURL:)]) {
                    fileOrUrl = [self.focusDelegate focusSensor:self
                                               mappedNameForURL:fileOrUrl];
                }
            }
            currentEvent = [self createEventFromApplication:frontApp
                                                withFileUrl:fileOrUrl
                                                windowTitle:windowTitle
                                                       type:KSEventTypeDidGetFocus];
        } else {
//            LogMessage(kKSLogTagFocusSensor, kKSLogLevelDebug, @"Will not start recording application: %@", frontApp.localizedName);
        }
        
        if(!loseFocusEvent && !currentEvent)
            return;
        
        // Saving the context here should not be necessary.
        // The recorded events can be discarded immediately after sending to server!
#ifndef kKSIsSaveToPersistentStoreDisabled
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            // will be executed on the main thread
            if(success) {
#endif
                // we have to wait for the server to process the first event before sending another one.
                // the first event MUST be a lose focus event!
                if(loseFocusEvent) {
                    [self.delegate sensor:self didRecordEvent:loseFocusEvent finished:^{
                        if(currentEvent) {
                            // if this application is on the blacklist, only the loseFocus event will have been sent.
                            [self.delegate sensor:self didRecordEvent:currentEvent finished:nil];
                        }
                    }];
                } else {
                    // no lose focus event -> don't stop recording this application and move on to the current event.
                    if(currentEvent) {
                        // if this application is on the blacklist, nothing will be sent.
                        [self.delegate sensor:self didRecordEvent:currentEvent finished:nil];
                    }
                }
                
                
#ifndef kKSIsSaveToPersistentStoreDisabled
            } else {
                    LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Saving the recorded event (%@) failed...", currentEvent);
            }
        }];
#endif
    });
}

#pragma mark Helper

/// Asks the delegate whether or not to record the application in question.
- (BOOL)shouldRecordApplication:(NSRunningApplication *)application
{
    BOOL shouldRecordApplication = YES;
    if(self.focusDelegate && [self.focusDelegate respondsToSelector:@selector(focusSensor:shouldRecordApplication:)]) {
        shouldRecordApplication = [self.focusDelegate focusSensor:self
                                          shouldRecordApplication:application];
    }
    return shouldRecordApplication;
}

- (KSFocusEvent *)createEventFromApplication:(NSRunningApplication *)application
                                 withFileUrl:(NSString *)fileOrUrl
                                 windowTitle:(NSString *)windowTitle
                                        type:(KSEventType)type
{
    static KSFocusEvent *oldEvent = nil;
    
    KSFocusEvent *currentEvent = [KSFocusEvent createInContext:[NSManagedObjectContext defaultContext]];
    [currentEvent setTimestamp:[NSDate date]];
    [currentEvent setProcessID:[NSString stringWithFormat:@"%i", application.processIdentifier]];
    [currentEvent setProcessName:application.localizedName];
    [currentEvent setSensorID:self.sensorID];
    [currentEvent setFilePath:fileOrUrl ?: @""];
    [currentEvent setWindowTitle:windowTitle ?: application.localizedName];
    [currentEvent setScreenshotPath:nil];
    [currentEvent setType:type];
    
    if(oldEvent &&
       ([[KSUtils dateAsString:oldEvent.timestamp] isEqualToString:[KSUtils dateAsString:currentEvent.timestamp]]) &&
       (oldEvent.windowTitle == currentEvent.windowTitle ||
        oldEvent.processID == currentEvent.processID)) {
           LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"WARNING: Two events with the exact same timestamp recorded - how is this possible? The two events were:\n1) %@ \n2) %@", oldEvent, currentEvent);
//           oldEvent = currentEvent;
//           return nil;
    }
    
    oldEvent = currentEvent;
    LogMessage(kKSLogTagFocusSensor, kKSLogLevelDebug, @"Recording focus event: %@", currentEvent);
    
    return currentEvent;
}


- (NSString *)urlOrFileOfApplication:(NSRunningApplication *)application isURL:(BOOL *)isURL;
{
    NSString *scriptName = nil;
    NSString *functionName = nil;
    if([self isBrowser:application]) {
        scriptName = @"UrlFromBrowser";
        functionName = @"getactiveurl";
        *isURL = YES;
    } else {
        scriptName = @"ActiveFile";
        functionName = @"getactivefile";
        *isURL = NO;
    }
    NSDictionary *errorInfo = nil;
    NSAppleEventDescriptor *result = [KSUtils executeApplescriptWithName:scriptName
                                                            functionName:functionName
                                                               arguments:@[application.localizedName]
                                                         errorDictionary:&errorInfo];
    
    if(errorInfo) {
        LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Error when executing AppleScript: %@", errorInfo);
        return nil;
    } else {
//        LogMessage(kKSLogTagFocusSensor, kKSLogLevelInfo, @"Got url or file: %@", [result stringValue]);
    }
    
    return [result stringValue];
}

- (NSString *)windowTitleOfApplication:(NSRunningApplication *)application
{
    NSDictionary *errorDict;
    NSAppleEventDescriptor *result = [KSUtils executeApplescriptWithName:@"WindowTitle"
                                                            functionName:@"getwindowtitle"
                                                               arguments:@[application.localizedName]
                                                         errorDictionary:&errorDict];
    if(errorDict) {
        LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Error when executing Applescript: %@", errorDict);
        return nil;
    } else {
//        LogMessage(kKSLogTagFocusSensor, kKSLogLevelInfo, @"Got window title: %@", [result stringValue]);
    }
    return [result stringValue];
}

#pragma mark HELPER
- (BOOL)isBrowser:(NSRunningApplication *)application
{
    static NSSet *browserNames = nil;
    if(!browserNames)
        browserNames = [NSSet setWithObjects:@"Safari", @"Google Chrome", @"Opera", nil];
    return [browserNames containsObject:application.localizedName];
}

- (void)sendLoseFocusEventForCurrentApplication
{
    KSFocusEvent *loseFocusEvent = nil;
    if(self.previousApplication &&
       [self.focusDelegate focusSensor:self shouldRecordApplication:self.previousApplication]) {
        loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                              withFileUrl:self.previousFileOrUrl
                                              windowTitle:self.previousWindowTitle
                                                     type:KSEventTypeDidLoseFocus];
    }
    
    self.previousApplication = nil;
    self.previousFileOrUrl = nil;
    self.previousWindowTitle = nil;
    
#ifndef kKSIsSaveToPersistentStoreDisabled
    [loseFocusEvent.managedObjectContext saveOnlySelfAndWait];
#endif
    [self.delegate sensor:self didRecordEvent:loseFocusEvent finished:nil];
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    KS_dispatch_sync_reentrant(self.applescriptQueue, ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(handleTimerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
        if([self.timer respondsToSelector:@selector(setTolerance:)]) {
            [self.timer setTolerance:0.1f]; // even a small tolerance will improve power savings.
        }
    });
    
    if(self.timer)
        return YES;
    else
        return NO;
}

- (BOOL)_unregisterForEvents
{
    KS_dispatch_sync_reentrant(self.applescriptQueue, ^{
        [self.timer invalidate];
        self.timer = nil;
        
        [self sendLoseFocusEventForCurrentApplication];
    });
    
    return YES; // nothing can go wrong here
}

@end