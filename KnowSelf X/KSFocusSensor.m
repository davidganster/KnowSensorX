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
        
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            // will be executed on the main thread
            if(success) {
                if(loseFocusEvent) {
                    [self.delegate sensor:self didRecordEvent:loseFocusEvent];
                }
                [self.delegate sensor:self didRecordEvent:currentEvent];
            } else {
                LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Saving the recorded event (%@) failed...", currentEvent);
            }
        }];
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
    
    // TODO: filepath and window title shouldn't be the same
    
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
    // send lose focus event:
    // TODO: encapsulate in function.
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
    
    [loseFocusEvent.managedObjectContext saveOnlySelfAndWait];
    [self.delegate sensor:self didRecordEvent:loseFocusEvent];
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    
#warning Subscribe to IdleSensorDidRegisterUserIdle event!
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(handleTimerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    
    if(self.timer)
        return YES;
    else return NO;
}

- (BOOL)_unregisterForEvents
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self sendLoseFocusEventForCurrentApplication];
    
    return YES; // nothing can go wrong here
}

@end