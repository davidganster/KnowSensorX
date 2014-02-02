//
//  KSSpecialApplicationsViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 02/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSSpecialApplicationsViewController.h"
#import "KSUserInfo.h"

@interface KSSpecialApplicationsViewController ()

@property (weak) IBOutlet NSPopUpButton *isBlacklistPopupButton;
@property (weak) IBOutlet NSTableView *applicationsTableView;
@property (nonatomic, strong) NSMutableArray *applications;

@end

@implementation KSSpecialApplicationsViewController

- (id)init
{
    self = [super initWithNibName:@"KSSpecialApplicationsViewController" bundle:nil];
    if (self) {
        _applications = [[[[KSUserInfo sharedUserInfo] specialApplications] allObjects] mutableCopy];
    }
    return self;
}

- (void)awakeFromNib
{
    static BOOL firstTime = YES;
    if(firstTime) {
        firstTime = NO;
        // tags: don't record = 1 (is blacklist), record only = 0 (whitelist).
        [self.isBlacklistPopupButton selectItemWithTag:[[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]];
    }
}

- (void)sortApplications
{
//    [self.applications sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        // todo
//    }];
}

- (IBAction)addButtonPressed:(id)sender
{
    // open file dialog
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setAllowsMultipleSelection:YES];
    [panel setAllowedFileTypes:@[@"app"]];
    [panel setAllowsOtherFileTypes:NO];
    [panel setCanChooseDirectories:NO];
    
    NSInteger clicked = [panel runModal];
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            [[KSUserInfo sharedUserInfo] addSpecialApplicationsObject:url];
        }
    }
    self.applications = [[[[KSUserInfo sharedUserInfo] specialApplications] allObjects] mutableCopy];
    [self.applicationsTableView reloadData];
}

- (IBAction)removeButtonPressed:(id)sender
{
    NSIndexSet *selectedRows = [self.applicationsTableView selectedRowIndexes];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.applications.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSTableCellView *applicationCell = [tableView makeViewWithIdentifier:@"ApplicationView" owner:self];
    
    NSString *title = [self.applications[row] lastPathComponent];
    NSBundle *appBundle = [NSBundle bundleWithURL:self.applications[row]];
    NSString *fullPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:appBundle.bundleIdentifier];
    NSImage *image = [[NSWorkspace sharedWorkspace] iconForFile:fullPath];
    applicationCell.textField.stringValue = title;
    applicationCell.imageView.image = image;
    
    return applicationCell;
}

#pragma mark - TableView Delegate
- (BOOL)tableView:(NSTableView *)tableView
      acceptDrop:(id<NSDraggingInfo>)info
             row:(NSInteger)row
   dropOperation:(NSTableViewDropOperation)dropOperation
{
    // TODO
    return NO;
}

@end