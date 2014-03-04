//
//  KSProject.h
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
