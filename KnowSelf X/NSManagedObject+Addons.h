//
//  NSManagedObject+Addons.h
//  KnowSensor X
//
//  Created by Joerg Simon on 15.11.12.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Addons)
- (NSMutableDictionary *)changedValuesMutable;

- (NSMutableDictionary *)dictRepresentation;
- (NSMutableDictionary *)dictRepresentationIncludeSubentities:(BOOL)includeSubentities;

- (void)didExportToDictionary:(NSMutableDictionary *)dict;

@property (retain, nonatomic) NSMutableArray *errorsOnLastImport;

@end
