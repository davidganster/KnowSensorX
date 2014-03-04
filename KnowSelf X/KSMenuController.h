//
//  KSMenuController.h
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

#import <Cocoa/Cocoa.h>
#import "KSProjectController.h"

@class KSProject;
@class KSActivity;

/**
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
