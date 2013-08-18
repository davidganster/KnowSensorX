//
//  KSSensorViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 18/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensorViewController.h"
#import "KSFocusSensor.h"
#import "KSIdleSensor.h"

@interface KSSensorViewController ()

@property(nonatomic, strong) NSArray *eventBuffer;
@property(nonatomic, assign) NSInteger maxEventBufferSize;

@end

@implementation KSSensorViewController

- (id)init
{
    self = [super initWithNibName:@"KSSensorViewController" bundle:nil];
    if (self) {
        // Initialization code here.
    }
    
    // init sensors:
    KSFocusSensor *focusSensor = [[KSFocusSensor alloc] initWithDelegate:self];
    KSIdleSensor *idleSensor = [[KSIdleSensor alloc] initWithDelegate:self];
    self.sensors = @[focusSensor, idleSensor];
    
    //    [self.sensors makeObjectsPerformSelector:@selector(startRecordingEvents)];

    return self;
}

- (void)loadView
{
    [super loadView];
    self.sensorsTableView.delegate = self;
    self.sensorsTableView.dataSource = self;
}


#pragma mark KSSensorDelegateProtocol
-(void)sensor:(KSSensor *)sensor didRecordEvent:(KSEvent *)event
{
    NSLog(@"Event: %@", event);
}

#pragma mark NSTableView Protocol methods

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.sensors.count;
}


-(NSView *)tableView:(NSTableView *)tableView
  viewForTableColumn:(NSTableColumn *)tableColumn
                 row:(NSInteger)row
{
    NSTableCellView *cellView  = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    if(cellView == nil) {
        cellView = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, tableView.frame.size.width, 0)];
        cellView.identifier = @"MyView";
    }
    
    cellView.textField.stringValue = [self.sensors[row] name];
    
    return cellView;
}

@end
