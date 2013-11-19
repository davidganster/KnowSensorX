//
//  KSMenuController.h
//  KnowSensor X
//
//  Created by David Ganster on 19/11/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KSProject;
@class KSActivity;

/**
 @author David Ganster
 The KSMenuController class encapsulates all interaction with the status bar menu, such as setting/updating
 the project list, current activity etc.
 @note The KSMenu is dependant on one layout constraint: The first 3 items are reserved
 for "Current Project/Activty", <current project/activity> and <seperator>.
 Any changes after these three items do not require any changes in code, but be careful if you
 insert new items at the front!
 */
@interface KSMenuController : NSObject

/// The project whose name will be shown in the second menu item.
@property(nonatomic, strong) KSProject *currentProject;

/// The activity whose name will be shown in the second menu item.
@property(nonatomic, strong) KSActivity *currentActivity;

/// An array of all projects, will be shown in the 'Projects >' submenu.
@property(nonatomic, strong) NSArray *projectList;

/// The NSMenu managed by this class.
/// @note Do not modify this object from outside, it will mess up the controller's logic.
@property (readonly, strong) IBOutlet NSMenu *menu;

@end
