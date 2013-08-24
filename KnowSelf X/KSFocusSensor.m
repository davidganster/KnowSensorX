//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSGlobals.h"
#import "KSFocusEvent+Addons.h"
#import "NSAppleEventDescriptor+NDCoercion.h"

@implementation KSFocusSensor

-(id)initWithDelegate:(id<KSSensorDelegateProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if(self) {
        self.sensorID = kKSSensorIDFocusSensor;
        self.name = kKSSensorNameFocusSensor;
    }
    return self;
}

#pragma mark Event Handling
- (void)handleApplicationBecameActive:(NSNotification *)event
{
    NSRunningApplication *frontApp = [[NSWorkspace sharedWorkspace] frontmostApplication];
    NSLog(@"app name = %@", frontApp.localizedName);
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *fileOrUrl = [self urlOrFileOfApplication:frontApp];
        NSLog(@"filename or url = %@", fileOrUrl);
        
        KSFocusEvent *currentEvent = [KSFocusEvent createInContext:[NSManagedObjectContext defaultContext]];
        [currentEvent setTimestamp:[NSDate date]];
        [currentEvent setProcessID:[NSString stringWithFormat:@"%i", frontApp.processIdentifier]];
        [currentEvent setProcessName:frontApp.localizedName];
        [currentEvent setSensorID:self.sensorID];
        // todo: filepath and window title shouldn't be the same
        [currentEvent setFilePath:fileOrUrl];
        [currentEvent setWindowTitle:fileOrUrl];
        [currentEvent setScreenshotPath:nil];
        [currentEvent setType:kKSEventTypeDidGetFocus];
        
        [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            if(success) {
                [self.delegate sensor:self didRecordEvent:currentEvent];
            } else {
                NSLog(@"Saving the recorded event (%@) failed...", currentEvent);
            }
        }];
    });
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
    return YES; // nothing can go wrong here, right?
}

- (BOOL)_unregisterForEvents
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self
                                                                  name:NSWorkspaceDidActivateApplicationNotification
                                                                object:nil];
    return YES; // nothing can go wrong here, right?
}

@end