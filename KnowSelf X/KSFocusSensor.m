//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSFocusEvent+Addons.h"
#import "NSAppleEventDescriptor+NDCoercion.h"


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
    NSAppleEventDescriptor *result = [self executeApplescriptWithName:scriptName
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
    NSAppleEventDescriptor *result = [self executeApplescriptWithName:@"WindowTitle"
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

- (NSAppleEventDescriptor *)executeApplescriptWithName:(NSString *)scriptName
                                          functionName:(NSString *)functionName
                                             arguments:(NSArray *)args
                                       errorDictionary:(NSDictionary **)errorDict
{
    NSString *pathAsString = [[NSBundle mainBundle] pathForResource:scriptName
                                                             ofType:@"scpt"];
    
    if(!pathAsString) {
        *errorDict = @{@"info" : [NSString stringWithFormat:@"Script with name %@ not found in main bundle.", scriptName]};
        return nil;
    }
    
    NSAppleEventDescriptor *descriptor;
    
    NSURL *url = [NSURL fileURLWithPath:pathAsString];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:url error:errorDict];
    
    if(*errorDict) {
        return nil;
    }
    
    descriptor = [[NSAppleEventDescriptor alloc] initWithSubroutineName:functionName
                                                         argumentsArray:args];
    
    NSAppleEventDescriptor *result = [script executeAppleEvent:descriptor error:errorDict];
    
    if(*errorDict)
        return nil;
    return result;
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    
//    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
//                                                           selector:@selector(handleApplicationBecameActive:)
//                                                               name:NSWorkspaceDidActivateApplicationNotification
//                                                             object:nil];
    
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
//    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
//                                                                  name:NSWorkspaceDidActivateApplicationNotification
//                                                                object:nil];
    
    [self.timer invalidate];
    self.timer = nil;
    return YES; // nothing can go wrong here
}

@end