//
//  KSActivity.h
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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"
#import "KSImportable.h"

@class KSProject;

/**
 *  Describes an activity object as returned from the server.
 *  Mirrors the DataModel on the KnowServer.
 */
@interface KSActivity : NSObject<KSExportable, KSImportable>

/// The ID of the activity, as returned from the server. Uniquely identifies this activity.
/// @warning This property should not be changed after retrieving an activity from the server. A new ID to be used will be returned by the server when a new activity is uploaded. KSAPIClient takes care of correctly setting the updated ID, so this property should never be changed afterwards.
@property (nonatomic, retain) NSString * activityID;
/// The color of the activity. Mirrors project.color, because the server does not send colors for individual acitivies (only projects).
@property (nonatomic, retain) NSString * color;
/// The date when this activity has started recording.
@property (nonatomic, retain) NSDate * startDate;
/// The date when this activity has stopped recording.
@property (nonatomic, retain) NSDate * endDate;
/// The name of the activity. *Not* unique, as activities with the same name may be recorded many times (every time an activity is started/stopped, a new activity is created.).
@property (nonatomic, retain) NSString * name;
/// The `name` of the connected project. Not needed anymore, but useful for quickly checking the associated project's name.
@property (nonatomic, retain) NSString * projectName;
/// The connected KSProject, used to export the project's name and ID when sending an activity to the server.
@property (nonatomic, retain) KSProject *project;

@end
