//
//  KSURLMappingViewController.m
//  KnowSensor X
//
//  Created by David Ganster on 05/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import "KSURLMappingViewController.h"
#import "KSUserInfo.h"

/**
 *  This class makes dealing with tableview cells easier as it encapsulates the validation logic 
 *  for URL mappings - this is important when adding a new mapping in the UI.
 *  It also automatically updates the corresponding entry in KSUserInfo, it any of its members are changed.
 *  @author David Ganster
 */
@interface KSURLMapping : NSObject
/// The URL to be mapped.
@property(nonatomic, strong) NSString *URL;
/// The mapped name.
@property(nonatomic, strong) NSString *mappedName;

/**
 *  Checks if the URL mapping is valid, whereas 'valid' means that neither URL nor mappedName is nil (or empty)
 *
 *  @return YES if neither URL nor mappedName is nil or empty.
 */
- (BOOL)isValid;
@end

@implementation KSURLMapping

- (BOOL)isValid
{
    return (self.URL.length && self.mappedName.length);
}

- (void)setURL:(NSString *)URL
{
    if(self.URL && self.mappedName) {
        // already existed, need to check if we need to update KSUserInfo!
        NSString *oldURL = [[KSUserInfo sharedUserInfo] URLMappings][self.URL];
        if(oldURL) {
            [[KSUserInfo sharedUserInfo] removeURLMappingWithURL:self.URL];
            [[KSUserInfo sharedUserInfo] addURLMappingWithMappedName:self.mappedName forURL:self.URL];
        }
    }
    _URL = URL;
}

- (void)setMappedName:(NSString *)mappedName
{
    if(self.URL && self.mappedName) {
        // full new entry, will update the exisiting one with the new data!
        [[KSUserInfo sharedUserInfo] addURLMappingWithMappedName:mappedName forURL:self.URL];
    }
    _mappedName = mappedName;
}

@end


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

/// In case a mapping is edited or added, this KSURLMapping will refer to the edited/added item.
/// It is used for easier handling of erroneous inputs (such as empty mappings, empty URLs etc).
@property (nonatomic, strong) KSURLMapping *tempMapping;
@end

@implementation KSURLMappingViewController

- (id)init
{
    self = [super initWithNibName:@"KSURLMappingViewController" bundle:nil];
    if(self) {
        _URLMappings = [[NSMutableArray alloc] init];
        for (NSString *url in [[[KSUserInfo sharedUserInfo] URLMappings] allKeys]) {
            KSURLMapping *mapping = [[KSURLMapping alloc] init];
            mapping.URL = url;
            mapping.mappedName = [[KSUserInfo sharedUserInfo] URLMappings][url];
            [_URLMappings addObject:mapping];
        }
        [self sortURLMappings];
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
        // double clicked into last row+1 or below: add new row.
        [self addMappingButtonPressed:nil];
    }
}

- (IBAction)addMappingButtonPressed:(id)sender
{
    if(!self.tempMapping) {
        self.tempMapping = [[KSURLMapping alloc] init];
        self.tempMapping.URL = @"";
        self.tempMapping.mappedName = @"";
        [self.tableView reloadData];
    }
    [self.tableView editColumn:0
                           row:self.URLMappings.count
                     withEvent:nil
                        select:YES];
}

- (IBAction)removeMappingButtonPressed:(id)sender
{
    NSMutableIndexSet *selectedIndexes = [[self.tableView selectedRowIndexes] mutableCopy];
    if([selectedIndexes containsIndex:self.URLMappings.count]) {
        self.tempMapping = nil;
        [selectedIndexes removeIndex:self.URLMappings.count];
    }
    NSArray *arrayToBeRemoved = [self.URLMappings objectsAtIndexes:selectedIndexes];
    NSMutableDictionary *newDict = [[[KSUserInfo sharedUserInfo] URLMappings] mutableCopy];
    for (KSURLMapping *mapping in arrayToBeRemoved) {
        [newDict removeObjectForKey:mapping.URL];
    }
    
    [self.URLMappings removeObjectsInArray:arrayToBeRemoved];
    [[KSUserInfo sharedUserInfo] setURLMappings:newDict];
    [self.tableView reloadData];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.URLMappings.count + (self.tempMapping ? 1 : 0);
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *returnValue = nil;
    if(tableColumn == self.URLColumn) {
        if(row < self.URLMappings.count)
            returnValue =[(KSURLMapping *)self.URLMappings[row] URL];
        else
            returnValue = [self.tempMapping URL];
    } else {
        if(row < self.URLMappings.count)
            returnValue = [(KSURLMapping *)self.URLMappings[row] mappedName];
        else
            returnValue = [self.tempMapping mappedName];
    }
    return returnValue;
}

#pragma mark - TableView Delegate

- (void)tableView:(NSTableView *)tableView
   setObjectValue:(id)object
   forTableColumn:(NSTableColumn *)tableColumn
              row:(NSInteger)row
{
    if(!object) {
        return;
    }
    
    if(tableColumn == self.URLColumn) {
        KSURLMapping *editedMapping = self.tempMapping;
        if(row < self.URLMappings.count) {
            editedMapping = self.URLMappings[row];
        }
        [editedMapping setURL:object];
    } else if(tableColumn == self.mappedNameColumn) {
        KSURLMapping *editedMapping = self.tempMapping;
        if(row < self.URLMappings.count) {
            editedMapping = self.URLMappings[row];
        }
        [editedMapping setMappedName:object];
    }
    
    if([self.tempMapping isValid]) {
        [self.URLMappings addObject:self.tempMapping];
        [self sortURLMappings];
        self.tempMapping = nil;
    }
}


- (BOOL)control:(NSControl *)control
       textView:(NSTextView *)textView
doCommandBySelector:(SEL)commandSelector
{
    if(commandSelector == @selector(insertTab:) ||
       commandSelector == @selector(insertBacktab:)) {
        unsigned long columnToSelect = 0;
        int increment = 1;
        BOOL canSelectNextOrPreviousRow = [self numberOfRowsInTableView:self.tableView] > self.tableView.editedRow+1;
        BOOL shouldSelectNextOrPreviousColumn = self.tableView.editedColumn < self.tableView.tableColumns.count-1;
        if(commandSelector == @selector(insertBacktab:)) {
            columnToSelect = self.tableView.tableColumns.count - 1;
            increment = -1;
            canSelectNextOrPreviousRow = self.tableView.editedRow > 0;
            shouldSelectNextOrPreviousColumn = self.tableView.editedColumn > 0;
        }
        if(shouldSelectNextOrPreviousColumn) {
            [self.tableView editColumn:self.tableView.editedColumn+increment
                                   row:self.tableView.editedRow
                             withEvent:nil
                                select:YES];
        } else if(canSelectNextOrPreviousRow) {
            [self.tableView editColumn:columnToSelect
                                   row:self.tableView.editedRow+increment
                             withEvent:Nil
                                select:YES];
        } else {
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - Helper
- (void)sortURLMappings
{
    [_URLMappings sortUsingComparator:^NSComparisonResult(KSURLMapping *obj1, KSURLMapping *obj2) {
        return [obj1.URL compare:obj2.URL options:NSCaseInsensitiveSearch];
    }];
}

@end
