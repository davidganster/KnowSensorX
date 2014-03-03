//
//  KSActivity.h
//  KnowSensor X
//
//  Created by David Ganster on 05/01/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

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
