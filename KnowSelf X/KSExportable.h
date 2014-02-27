//
//  KSExportable.h
//  KnowSensor X
//
//  Created by David Ganster on 22/02/14.
//  Copyright (c) 2014 David Ganster. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Simple protocol that defines a method to export the receiver to a dictionary,
 *  which must in turn be JSON-exportable.
 *  This means, that any value set for a key *must* be serializable by the built-in
 *  JSON serializer (see NSJSONSerialization for more information).
 */
@protocol KSExportable <NSObject>

/**
 *  Tells the receiver to export itself into a JSON-serializable dictionary.
 *  Only primitive types may be used (including NSString, NSNumber, NSArray, NSDictionary, but *not* NSDate)
 *  as values in the resulting dictionary.
 *
 *  @return The resulting dictionary or nil if export failed.
 */
- (NSDictionary *)dictRepresentation;

@end
