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
    }
    return self;
}

#pragma mark Event Handling
- (void)handleApplicationBecameActive:(NSNotification *)event
{
    NSRunningApplication *frontApp = [[NSWorkspace sharedWorkspace] frontmostApplication];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        KSFocusEvent *loseFocusEvent = nil;
        if(self.previousApplication) {
            loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                                  withFileUrl:self.previousFileOrUrl
                                                         type:KSEventTypeDidLoseFocus];
        }
        
        NSString *fileOrUrl = [self urlOrFileOfApplication:frontApp];
        self.previousApplication = frontApp;
        self.previousFileOrUrl = fileOrUrl;
        KSFocusEvent *currentEvent = [self createEventFromApplication:frontApp
                                                          withFileUrl:fileOrUrl
                                                                 type:KSEventTypeDidGetFocus];
        
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            if(success) {
                if(loseFocusEvent) {
                    [self.delegate sensor:self didRecordEvent:loseFocusEvent];
                }
                [self.delegate sensor:self didRecordEvent:currentEvent];
            } else {
                NSLog(@"Saving the recorded event (%@) failed...", currentEvent);
            }
        }];
    });
}

#pragma mark Helper

- (KSFocusEvent *)createEventFromApplication:(NSRunningApplication *)application
                                 withFileUrl:(NSString *)fileOrUrl
                                        type:(KSEventType)type
{
    KSFocusEvent *currentEvent = [KSFocusEvent createInContext:[NSManagedObjectContext defaultContext]];
    [currentEvent setTimestamp:[NSDate date]];
    [currentEvent setProcessID:[NSString stringWithFormat:@"%i", application.processIdentifier]];
    [currentEvent setProcessName:application.localizedName];
    [currentEvent setSensorID:self.sensorID];
    
    // todo: filepath and window title shouldn't be the same
    [currentEvent setFilePath:fileOrUrl];
    [currentEvent setWindowTitle:fileOrUrl];
    [currentEvent setScreenshotPath:nil];
    [currentEvent setType:type];
    return currentEvent;
}


- (NSString *)urlOrFileOfApplication:(NSRunningApplication *)application
{
    NSAppleScript *script = nil;
    NSAppleEventDescriptor *descriptor;
    NSString *pathAsString = nil;
    NSString *functionName = nil;
    
    if([self isBrowser:application]) {
        pathAsString = [[NSBundle mainBundle] pathForResource:@"UrlFromBrowser"
                                                       ofType:@"scpt"];
        functionName = @"getactiveurl";
    } else {
        
        pathAsString = [[NSBundle mainBundle] pathForResource:@"ActiveFile"
                                                       ofType:@"scpt"];
        functionName = @"getactivefile";
    }
    NSURL *url = [NSURL fileURLWithPath:pathAsString];
    NSDictionary *errorDict = nil;
    script = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errorDict];
    descriptor = [[NSAppleEventDescriptor alloc] initWithSubroutineName:functionName
                                                         argumentsArray:@[application.localizedName]];
    
    NSDictionary *errorInfo = nil;
    NSAppleEventDescriptor *result = [script executeAppleEvent:descriptor error:&errorInfo];
    
    if(errorInfo)
        NSLog(@"Error infor = %@", errorInfo);
    return [result stringValue];
}

- (BOOL)isBrowser:(NSRunningApplication *)application
{
    static NSSet *browserNames = nil;
    if(!browserNames)
        browserNames = [NSSet setWithObjects:@"Safari", @"Google Chrome", @"Opera", nil];
    return [browserNames containsObject:application.localizedName];
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(handleApplicationBecameActive:)
                                                               name:NSWorkspaceDidActivateApplicationNotification
                                                             object:nil];
    return YES; // nothing can go wrong here
}

- (BOOL)_unregisterForEvents
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
                                                                  name:NSWorkspaceDidActivateApplicationNotification
                                                                object:nil];
    return YES; // nothing can go wrong here
}

@end