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
        [self sortApplications];
    }
}

- (void)sortApplications
{
    [self.applications sortUsingComparator:^NSComparisonResult(NSString *url1, NSString *url2) {
        NSURL *app1 = [NSURL URLWithString:url1];
        NSURL *app2 = [NSURL URLWithString:url2];
        NSString *appName1 = [app1 lastPathComponent];
        NSString *appName2 = [app2 lastPathComponent];
        return [appName1 compare:appName2 options:NSCaseInsensitiveSearch];
    }];
}

- (IBAction)addButtonPressed:(id)sender
{
    // open file dialog
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setDirectoryURL:[NSURL URLWithString:@"/Applications/"]];
    [panel setCanChooseFiles:YES];
    [panel setAllowsMultipleSelection:YES];
    [panel setAllowedFileTypes:@[@"app"]];
    [panel setAllowsOtherFileTypes:NO];
    [panel setCanChooseDirectories:NO];
    
    NSInteger clicked = [panel runModal];
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            [[KSUserInfo sharedUserInfo] addSpecialApplicationsObject:[url absoluteString]];
        }
    }
    
    self.applications = [[[[KSUserInfo sharedUserInfo] specialApplications] allObjects] mutableCopy];
    [self sortApplications];
    [self.applicationsTableView reloadData];
}

- (IBAction)removeButtonPressed:(id)sender
{
    NSIndexSet *selectedRows = [self.applicationsTableView selectedRowIndexes];
    [self.applications removeObjectsAtIndexes:selectedRows];
    [[KSUserInfo sharedUserInfo] setSpecialApplications:[NSSet setWithArray:self.applications]];
    [self.applicationsTableView reloadData];
}

- (IBAction)blacklistPopupSelected:(NSPopUpButton *)sender
{
    NSInteger selectedIndex = sender.indexOfSelectedItem;
    [[KSUserInfo sharedUserInfo] setSpecialApplicationsAreBlacklist:selectedIndex];
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
    
    NSURL *url = [NSURL URLWithString:self.applications[row]];
    NSString *title = [url lastPathComponent];
    NSBundle *appBundle = [NSBundle bundleWithURL:url];
    NSString *fullPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:appBundle.bundleIdentifier];
    NSImage *image = [[NSWorkspace sharedWorkspace] iconForFile:fullPath];
    applicationCell.textField.stringValue = title;
    applicationCell.imageView.image = image;
    
    return applicationCell;
}

#pragma mark - TableView Delegate

//- (NSDragOperation)tableView:(NSTableView *)tableView
//               validateDrop:(id<NSDraggingInfo>)info
//                proposedRow:(NSInteger)row
//      proposedDropOperation:(NSTableViewDropOperation)dropOperation
//{
//    return NSDragOperationCopy;
//}
//
//- (BOOL)tableView:(NSTableView *)tableView
//      acceptDrop:(id<NSDraggingInfo>)info
//             row:(NSInteger)row
//   dropOperation:(NSTableViewDropOperation)dropOperation
//{
//    // TODO
//    return NO;
//}

@end
