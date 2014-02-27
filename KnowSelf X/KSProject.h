//
//  KSProject.h
//  KnowSensor X
//
//  Created by David Ganster on 24/10/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSExportable.h"
#import "KSImportable.h"

@class KSActivity;

/**
 *  Describes a project object as returned from the server.
 *  Mirrors the DataModel on the KnowServer.
 */
@interface KSProject : NSObject<KSExportable, KSImportable>
/// The color of this project, represented by a HEX string with a leading hashtag (e.g. "#12FFAB").
@property (nonatomic, retain) NSString * color;
/// The name of the project. Must not contain any percentage-escapes when exporting to dictionary.
@property (nonatomic, retain) NSString * name;
/// The ID of the project, as returned from the server. Uniquely identifies this project.
/// @warning This property should not be changed after retrieving an project from the server. A new ID to be used will be returned by the server when a new project is uploaded. KSAPIClient takes care of correctly setting the updated ID, so this property should never be changed afterwards.
@property (nonatomic, retain) NSString * projectID;
/// All activities belonging to this project, in the order that they were added by the user.
@property (nonatomic, retain) NSOrderedSet *activities;
@end
