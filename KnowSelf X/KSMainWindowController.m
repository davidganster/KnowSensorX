//
//  KSMainWindowController.m
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSMainWindowController.h"
#import "KSEvent.h"
#import "KSFocusEvent+Addons.h"
#import "KSFocusSensor.h"
#import "KSIdleSensor.h"

@interface KSMainWindowController ()

@property(nonatomic, strong) NSArray *eventBuffer;
@property(nonatomic, assign) NSInteger maxEventBufferSize;

@end

@implementation KSMainWindowController

- (void)awakeFromNib
{
    // init here!
    KSFocusSensor *focusSensor = [[KSFocusSensor alloc] initWithDelegate:self];
    KSIdleSensor *idleSensor = [[KSIdleSensor alloc] initWithDelegate:self];
    
    self.sensors = @[focusSensor, idleSensor];
    
//    [self.sensors makeObjectsPerformSelector:@selector(startRecordingEvents)];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}



#pragma mark KSSensorDelegate methods

- (void)sensor:(KSSensor *)sensor didRecordEvent:(KSEvent *)event
{
    NSLog(@"did record an event: %@", event);
}

@end
