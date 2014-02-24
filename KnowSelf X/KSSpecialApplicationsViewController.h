//
//  KSSpecialApplicationsViewController.h
//  KnowSensor X
//
//  Created by David Ganster on 02/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 *  Manages a view where the user can edit their white- or blacklist.
 *  Displays all chosen applications in a table view, and acts as the data source and delegate
 *  of said table view.
 */
@interface KSSpecialApplicationsViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@end
