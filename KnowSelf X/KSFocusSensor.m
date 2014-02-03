//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSFocusEvent+Addons.h"


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
        NSString *fileOrUrl = [self urlOrFileOfApplication:frontApp];
        NSString *windowTitle = [self windowTitleOfApplication:frontApp];
        if(self.previousApplication.processIdentifier == frontApp.processIdentifier &&
           ([self.previousFileOrUrl isEqualToString:fileOrUrl] || self.previousFileOrUrl == fileOrUrl)) {
            // nothing has changed since the last poll
            return;
        }
        
        KSFocusEvent *loseFocusEvent = nil;
        if(self.previousApplication) {
            loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                                  withFileUrl:self.previousFileOrUrl
                                                  windowTitle:self.previousWindowTitle
                                                         type:KSEventTypeDidLoseFocus];
        }
        
        self.previousApplication = frontApp;
        self.previousFileOrUrl = fileOrUrl;
        self.previousWindowTitle = windowTitle;
        
        KSFocusEvent *currentEvent = [self createEventFromApplication:frontApp
                                                          withFileUrl:fileOrUrl
                                                          windowTitle:windowTitle
                                                                 type:KSEventTypeDidGetFocus];
#ifndef kKSIsSaveToPersistentStoreDisabled
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            // will be executed on the main thread
            if(success) {
#endif
                // we call the delegate regardless of whether saving to persistent store is enabled or not
                if(loseFocusEvent) {
                    [self.delegate sensor:self didRecordEvent:loseFocusEvent];
                }
                [self.delegate sensor:self didRecordEvent:currentEvent];
                
#ifndef kKSIsSaveToPersistentStoreDisabled
            } else {
                LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Saving the recorded event (%@) failed...", currentEvent);
            }
        }];
#endif
    });
}

#pragma mark Helper

- (KSFocusEvent *)createEventFromApplication:(NSRunningApplication *)application
                                 withFileUrl:(NSString *)fileOrUrl
                                 windowTitle:(NSString *)windowTitle
                                        type:(KSEventType)type
{
    KSFocusEvent *currentEvent = [KSFocusEvent createInContext:[NSManagedObjectContext defaultContext]];
    [currentEvent setTimestamp:[NSDate date]];
    [currentEvent setProcessID:[NSString stringWithFormat:@"%i", application.processIdentifier]];
    [currentEvent setProcessName:application.localizedName];
    [currentEvent setSensorID:self.sensorID];
    [currentEvent setFilePath:fileOrUrl ?: @""];
    [currentEvent setWindowTitle:windowTitle ?: application.localizedName];
    [currentEvent setScreenshotPath:nil];
    [currentEvent setType:type];
    return currentEvent;
}


- (NSString *)urlOrFileOfApplication:(NSRunningApplication *)application
{
    NSString *scriptName = nil;
    NSString *functionName = nil;
    
    if([self isBrowser:application]) {
        scriptName = @"UrlFromBrowser";
        functionName = @"getactiveurl";
    } else {
        
        scriptName = @"ActiveFile";
        functionName = @"getactivefile";
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
    if(self.previousApplication) {
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
    [self.delegate sensor:self didRecordEvent:loseFocusEvent];
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