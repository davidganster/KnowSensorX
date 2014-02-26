//
//  KSFocusSensor.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSFocusSensor.h"
#import "KSScreenshotGrabber.h"
#import "KSUserInfo.h"
#import "KSFocusEvent.h"

@interface KSFocusSensor ()

/// The previously recorded application. Needed to send lose focus events.
@property(nonatomic, strong) NSRunningApplication *previousApplication;
/// The previously recorded file (or url). Needed to send lose focus events.
@property(nonatomic, strong) NSString *previousFileOrUrl;
/// The previously recorded window title. Needed to send lose focus events.
@property(nonatomic, strong) NSString *previousWindowTitle;
/// Indicates if the previous application has been recorded - the blocked applications might
/// have changed between get/lose focus, but we always want to send lose focus events!
@property(nonatomic, assign) BOOL hasRecordedPreviousApplication;
/// Every time this timer fires, the KSFocusSensor will check for new focus events.
@property(nonatomic, strong) NSTimer *timer;
/// The queue that will be used to record events - executing applescripts takes a while,
/// so this needs to happen asynchronously.
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
                                                 selector:@selector(userStartedIdling:) // will send didLoseFocus event
                                                     name:kKSNotificationKeyUserIdleStart
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_registerForEvents) // will start sending events
                                                     name:kKSNotificationKeyUserIdleEnd
                                                   object:nil];
    }
    return self;
}

/**
 *  Invoked when receiving a kKSNotificationKeyUserIdleStart notification.
 *  Will call _unregisterForEventsFinished: with a nil finished block.
 *
 *  @param notification The 'user idle start' notification. Unused.
 */
- (void)userStartedIdling:(NSNotification *)notification
{
    [self _unregisterForEventsFinished:nil];
}

#pragma mark Event Handling
/// @name Event Handling

/**
 *  Called every time the timer fires - which is every second.
 *  Runs on the applescriptQueue.
 *  Checks the currenlty frontmost application and compares it to the 
 *  previouslyRecordedApplication.
 *  If they are not the same, a lose/get focus event is created and handed to the
 *  delegate.
 *  The focusDelegate will be asked whether or not to record the application, as
 *  well as for mapped URLs.
 *
 *  @param sender The timer that generated the event. Unused.
 */
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
        if(self.previousApplication &&
           ([self shouldRecordApplication:self.previousApplication] ||
            self.hasRecordedPreviousApplication)) {
            if([self isBrowser:self.previousApplication]) {
                if(self.previousFileOrUrl &&
                   self.focusDelegate &&
                   [self.focusDelegate respondsToSelector:@selector(focusSensor:mappedNameForURL:)]) {
                    self.previousFileOrUrl = [self.focusDelegate focusSensor:self
                                                            mappedNameForURL:self.previousFileOrUrl];
                }
            }
            KSScreenshotData *screenshotData = nil;
            // the server doesn't support screenshots on 'loseFocus' :(
            loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                                  withFileUrl:self.previousFileOrUrl
                                                  windowTitle:self.previousWindowTitle
                                                   screenshot:screenshotData
                                                         type:KSEventTypeDidLoseFocus];
        }
        
        self.previousApplication = frontApp;
        self.previousFileOrUrl = fileOrUrl;
        self.previousWindowTitle = windowTitle;
        
        KSFocusEvent *currentEvent = nil;
        if([self shouldRecordApplication:frontApp]) {
            self.hasRecordedPreviousApplication = YES;
            KSScreenshotData *screenshotData = nil;
            KSScreenshotQuality quality = [self.focusDelegate focusSensor:self
                                          screenshotQualityForApplication:frontApp];
            if(quality != KSScreenshotQualityNone) {
                 screenshotData = [KSScreenshotGrabber screenshotDataForApplication:frontApp
                                                                              scale:[KSUtils scaleForScreenshotQuality:quality]];
            }
            
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
                                                 screenshot:screenshotData
                                                       type:KSEventTypeDidGetFocus];
        } else {
            // should NOT record this application.
            self.hasRecordedPreviousApplication = NO;
        }
        
        if(!loseFocusEvent && !currentEvent)
            return;
        
        // We have to wait for the server to process the first event before sending another one.
        // The first event MUST be a lose focus event!
        // Overloading the server with events will result in 'dropped' events
        // that last for 0 seconds.
        if(loseFocusEvent) {
            [self.delegate sensor:self didRecordEvent:loseFocusEvent finished:^(BOOL success) {
                if(currentEvent) {
                    [self.delegate sensor:self didRecordEvent:currentEvent finished:nil];
                }
            }];
        } else if(currentEvent) {
            [self.delegate sensor:self didRecordEvent:currentEvent finished:nil];
        }
    });
}

#pragma mark Helper
/// @name Helper

/**
 *  Asks the delegate whether or not to record the application in question.
 *  Also checks if the delegate responds to the focusSensor:shouldRecordApplication:
 *  message. If it doesn't, YES is returned.
 *
 *  @param application The application that might be reocrded.
 *
 *  @return return-value of the delegate or YES if the delegate didn't respond.
 */
- (BOOL)shouldRecordApplication:(NSRunningApplication *)application
{
    BOOL shouldRecordApplication = YES;
    if(self.focusDelegate && [self.focusDelegate respondsToSelector:@selector(focusSensor:shouldRecordApplication:)]) {
        shouldRecordApplication = [self.focusDelegate focusSensor:self
                                          shouldRecordApplication:application];
    }
    return shouldRecordApplication;
}

/**
 *  Creates an event with the given parameters and returns it.
 *
 *  @param application    The application that will provide its name and process identifier.
 *  @param fileOrUrl      Will be set as the event's filePath.
 *  @param windowTitle    Will be set as the event's windowTitle.
 *  @param screenshotData Will be set as the event's screenshotData.
 *  @param type           Can be either KSEventTypeDidGetFocus or KSEventTypeDidLoseFocus.
 *
 *  @return The KSFocusEvent initialized with the given parameters.
 */
- (KSFocusEvent *)createEventFromApplication:(NSRunningApplication *)application
                                 withFileUrl:(NSString *)fileOrUrl
                                 windowTitle:(NSString *)windowTitle
                                  screenshot:(KSScreenshotData *)screenshotData
                                        type:(KSEventType)type
{
    KSFocusEvent *currentEvent = [[KSFocusEvent alloc] init];
    [currentEvent setTimestamp:[NSDate date]];
    [currentEvent setProcessID:[NSString stringWithFormat:@"%i", application.processIdentifier]];
    [currentEvent setProcessName:application.localizedName];
    [currentEvent setSensorID:self.sensorID];
    [currentEvent setFilePath:fileOrUrl ?: @""];
    [currentEvent setWindowTitle:windowTitle ?: application.localizedName];
    [currentEvent setScreenshot:screenshotData];
    [currentEvent setType:type];
    
    return currentEvent;
}

/**
 *  Executes an AppleScript that tries to return the application's filePath.
 *  The AppleScript that is be executed will either be 'URLFromBrowser' or 'ActiveFile',
 *  depending on whether or not the application is a browser (checked via the
 *  `isBrowser:` helper) the application.
 *
 *  @note This function will take a while to return, so it should not be called from the main thread.
 *
 *  @param application The application whose file/url should be extracted.
 *  @param isURL       A second return value. The caller has to provide a valid memory address to write to. Indicates if the returned value is a http-URL or file path.
 *
 *  @return The URL or file path of the frontmost document opened in `application`.
 */
- (NSString *)urlOrFileOfApplication:(NSRunningApplication *)application
                               isURL:(BOOL *)isURL;
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
    }
    
    return [result stringValue];
}

/**
 *  Executes an AppleScript that tries to return the application's window title.
 *
 *  @note This will only work for well-behaved Cocoa-applications.
 *
 *  @param application The application whose window title will be extracted.
 *
 *  @return The recorded window title or nil if the application didn't respond to the script.
 */
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

/**
 *  Helper method to check if the given application is a browser.
 *  @note Firefox will not return YES, because it's not applescript-ready.
 *
 *  @param application The application whose name will be checked.
 *
 *  @return YES if the application is Safari, Chrome or Opera. No otherwise.
 */
- (BOOL)isBrowser:(NSRunningApplication *)application
{
    static NSSet *browserNames = nil;
    if(!browserNames)
        browserNames = [NSSet setWithObjects:@"Safari", @"Google Chrome", @"Opera", @"SRWare Iron", @"Chromium", @"Dolphin", nil];
    return [browserNames containsObject:application.localizedName];
}

/**
 *  Helper method that sends a 'loseFocus' event for the current application.
 *
 *  @param finished The finished block to be executed once the server has acknowledged the event.
 */
- (void)sendLoseFocusEventForCurrentApplicationFinished:(void (^)(BOOL succesful))finished
{
    KSFocusEvent *loseFocusEvent = nil;
    if(self.previousApplication &&
       [self.focusDelegate focusSensor:self shouldRecordApplication:self.previousApplication]) {
        loseFocusEvent = [self createEventFromApplication:self.previousApplication
                                              withFileUrl:self.previousFileOrUrl
                                              windowTitle:self.previousWindowTitle
                                               screenshot:nil
                                                     type:KSEventTypeDidLoseFocus];
    } else {
        LogMessage(kKSLogTagFocusSensor, kKSLogLevelError, @"Will not send lose focus event upon unregistering for events. (black/whitelist)");
    }
    
    self.previousApplication = nil;
    self.previousFileOrUrl = nil;
    self.previousWindowTitle = nil;
    
    if(loseFocusEvent) {        
        [self.delegate sensor:self
               didRecordEvent:loseFocusEvent
                     finished:finished];
    }
}

@end

@implementation KSFocusSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(handleTimerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    if([self.timer respondsToSelector:@selector(setTolerance:)]) {
        [self.timer setTolerance:0.1f]; // even a small tolerance will improve power savings.
    }
    
    if(self.timer)
        return YES;
    else
        return NO;
}

- (void)_unregisterForEventsFinished:(void (^)(BOOL))finished
{
    dispatch_async(self.applescriptQueue, ^{
        [self.timer invalidate];
        self.timer = nil;
        [self sendLoseFocusEventForCurrentApplicationFinished:finished];
    });
}

@end