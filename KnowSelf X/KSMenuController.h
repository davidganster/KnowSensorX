//
//  KSMenuController.h
//  KnowSensor X
//
//  Created by David Ganster on 19/11/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KSProjectController.h"

@class KSProject;
@class KSActivity;

/**
 * @author David Ganster
 * The KSMenuController class encapsulates all interaction with the status bar menu, such as setting/updating
 * the project list, current activity etc. 
 * @note The KSMenu is dependant on one layout constraint: The first 3 items are reserved
 * for "Current Project/Activty", <current project/activity> and <seperator>.
 * Any changes after these three items do not require any changes in code, but be careful if you insert new items at the front!
 */
@interface KSMenuController : NSObject<KSProjectControllerEventObserver>

/// The activity whose name will be shown in the currentProjectMenuItem menu item.
@property(nonatomic, strong) KSActivity *currentActivity;

/// An array of all projects, will be shown in the 'Projects >' submenu.
@property(nonatomic, strong) NSArray *projectList;

/// The NSMenu managed by this class.
/// @note Do not modify this object from outside, it will mess up the controller's logic.
@property (readonly, strong) IBOutlet NSMenu *menu;


/**
 IBAction that shows the main window with the preference pane selected.
 @return void (IBAction)
 @param sender - The button that sent the event. Unused.
 */
- (IBAction)showPreferencePane:(id)sender;

/**
 IBAction that shows the WebApp in the default browser.
 @return void (IBAction)
 @param sender - The button that sent the event. Unused.
 */
- (IBAction)showWebApp:(id)sender;

/**
 IBAction that toggles private mode on/off.
 @return void (IBAction)
 @param sender - The button that sent the event. Unused.
 */
- (IBAction)togglePrivateMode:(NSMenuItem *)sender;

/**
 IBAction that shows the WebApp in the default browser, opened to the 'Write to diary' page.
 @return void (IBAction)
 @param sender - The button that sent the event. Unused.
 */
- (IBAction)writeToDiary:(id)sender;

/**
 IBAction that quits the application.
 @return void (IBAction)
 @param sender - The button that sent the event. Unused.
 */
- (IBAction)quit:(id)sender;

@end
