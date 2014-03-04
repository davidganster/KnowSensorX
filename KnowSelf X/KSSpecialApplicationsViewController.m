//
//  KSSpecialApplicationsViewController.m
//
//  Copyright (c) 2014 David Ganster (http://github.com/davidganster)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "KSSpecialApplicationsViewController.h"
#import "KSUserInfo.h"

@interface KSSpecialApplicationsViewController ()

@property (weak) IBOutlet NSPopUpButton *isBlacklistPopupButton;
@property (weak) IBOutlet NSTableView *applicationsTableView;

/// Used for keeping track of all currently chosen applications.
/// The corresponding KSUserInfo property is an NSSet (not ordered), but we want
/// the applications to always display in the same order (alphabetically) - so we use
/// this array internally.
@property (nonatomic, strong) NSMutableArray *applications;

@end

@implementation KSSpecialApplicationsViewController

- (id)init
{
    self = [super initWithNibName:@"KSSpecialApplicationsViewController" bundle:nil];
    if (self) {
        _applications = [[[[KSUserInfo sharedUserInfo] specialApplications] allObjects] mutableCopy];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userInfoDidImport:)
                                                     name:kKSNotificationUserInfoDidImport
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kKSNotificationUserInfoDidImport
                                                  object:nil];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    static BOOL firstTime = YES;
    if(firstTime) {
        firstTime = NO;
        // tags: don't record = 1 (is blacklist), record only = 0 (whitelist).
        [self.isBlacklistPopupButton selectItemWithTag:[[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]];
        [self sortApplications];
    }
}

/**
 *  This method will update the UI when a `kKSNotificationUserInfoDidImport` 
 *  notification is received.
 *
 *  @param notification The notification indicating that new settings were just imported. Unused.
 */
- (void)userInfoDidImport:(NSNotification *)notification
{
    [self.isBlacklistPopupButton selectItemWithTag:[[KSUserInfo sharedUserInfo] specialApplicationsAreBlacklist]];
    self.applications = [[[[KSUserInfo sharedUserInfo] specialApplications] allObjects] mutableCopy];
    [self sortApplications];
    [self.applicationsTableView reloadData];
}

/**
 *  Opens a dialog in an NSOpenPanel, pointing to the '/Applications/' folder.
 *  The user will only be able to choose '.app' files, but multiple ones at once.
 *  After the panel returns, the new applications will be added to 
 *  KUserInfo's 'specialApplications' set, then assigned to the internal array 
 *  and sorted, followed by a UI update (table view reload).
 *
 *  @param sender The button that generated the event. Unused.
 */
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

/**
 *  Removes the values of the currently selected rows from the 'specialApplications' 
 *  set in KSUserInfo.
 *  Updates the UI (reloads the table view).
 *
 *  @param sender The button that generated the event. Unused.
 */
- (IBAction)removeButtonPressed:(id)sender
{
    NSIndexSet *selectedRows = [self.applicationsTableView selectedRowIndexes];
    [self.applications removeObjectsAtIndexes:selectedRows];
    [[KSUserInfo sharedUserInfo] setSpecialApplications:[NSSet setWithArray:self.applications]];
    [self.applicationsTableView reloadData];
}

/**
 *  Indicates that the user selected either 'Record only' (= whitelist) or
 *  'Don't record' (= blacklist) in the popup button.
 *  Sends this info to KSUserInfo.
 *
 *  @param sender The popup button that generated the event. Its selected index will be used to determine which option was selected.
 */
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

#pragma mark - Helpers
/**
 *  Helper method for sorting the `applications` array by app name alphabetically
 *  Since the elements are full paths to their respective application's bundle, they
 *  are converted to NSURLs to extract their name, which will be used to sort them.
 */
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

@end
