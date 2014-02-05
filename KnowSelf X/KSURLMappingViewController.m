//
//  KSURLMappingViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 05/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSURLMappingViewController.h"
#import "KSUserInfo.h"

@interface KSURLMappingViewController ()

// IBOutlets
@property (weak) IBOutlet NSTableColumn *URLColumn;
@property (weak) IBOutlet NSTableColumn *mappedNameColumn;
@property (weak) IBOutlet NSTableView *tableView;

/// This class uses the `URLMappings` dictionary from the KSUserInfo class,
/// but displays URLs in a sorted manner.
/// To avoid sorting all the time, the URLs are sorted once and stored in this array.
/// They are then used as keys for the `URLMappings` dictionary from KSUserInfo.
@property (nonatomic, strong) NSMutableArray *URLMappings;

//@property (nonatomic, strong) NSString *
@end

@implementation KSURLMappingViewController

- (id)init
{
    self = [super initWithNibName:@"KSURLMappingViewController" bundle:nil];
    if(self) {
        _URLMappings = [[[[KSUserInfo sharedUserInfo] URLMappings] allKeys] mutableCopy];
        [_URLMappings sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        }];
    }
    return self;
}

- (void)awakeFromNib
{
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(doubleClick)];
    // set column width so that all columns are equally wide:
    for (NSTableColumn *column in self.tableView.tableColumns) {
        [column setWidth:self.tableView.frame.size.width/self.tableView.tableColumns.count];
    }
}

- (void)doubleClick
{
    if(self.tableView.clickedRow >= self.URLMappings.count) {
        // double clicked into last row+1 or below
        // TODO: add temp entry here and save when both fields are entered.
    }
}

- (IBAction)addMappingButtonPressed:(id)sender
{
}


- (IBAction)removeMappingButtonPressed:(id)sender
{
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.URLMappings.count;
}

- (NSView *)tableView:(NSTableView *)tableView
  viewForTableColumn:(NSTableColumn *)tableColumn
                 row:(NSInteger)row
{
    NSTableCellView *view = nil;
    if(tableColumn == self.URLColumn) {
        view = [tableView makeViewWithIdentifier:@"URLView" owner:self];
        view.textField.stringValue = self.URLMappings[row];
    } else if(tableColumn == self.mappedNameColumn) {
        view = [tableView makeViewWithIdentifier:@"NameView" owner:self];
        view.textField.stringValue = [[[KSUserInfo sharedUserInfo] URLMappings] objectForKey:self.URLMappings[row]];
    } else {
        LogMessage(kKSLogTagUI, kKSLogLevelError, @"Unknown column in URLMapping View: %@", tableColumn);
    }
    
    return view;
}

#pragma mark - TableView Delegate

-(void)tableView:(NSTableView *)tableView
  setObjectValue:(id)object
  forTableColumn:(NSTableColumn *)tableColumn
             row:(NSInteger)row
{
    NSString *newValue = object;
    if(newValue.length) {
        // we ignore empty cells.
    }
}

@end
