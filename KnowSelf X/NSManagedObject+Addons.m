//
//  NSManagedObject+Addons.m
//  KnowSensor X
//
//  Created by Joerg Simon on 15.11.12.
//
//

#import "NSManagedObject+Addons.h"
#import "NSString+MagicalDataImport.h"
#import "NSString+Repeat.h"
#import "NSMutableDictionary+Addons.h"
#import "MagicalRecordShorthand.h"
#import <objc/runtime.h>

// two main additions: the whole export part, and error handling on the import

static char const * const ErrorsOnLastImportKey = "ErrorsOnLastImport";

@implementation NSManagedObject (Addons)

#pragma mark ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - ERROR HANDLING ADDITIONS FOR IMPORT
// -----------------------------------------------------------------------------
// ERROR HANDLING ADDITIONS FOR IMPORT

@dynamic errorsOnLastImport;

- (NSMutableArray*)errorsOnLastImport
{
    return objc_getAssociatedObject(self, ErrorsOnLastImportKey);
}

- (void)setErrorsOnLastImport:(NSMutableArray *)errorsOnLastImport
{
    objc_setAssociatedObject(self, ErrorsOnLastImportKey, errorsOnLastImport, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    SEL originalSelector = @selector(MR_importValuesForKeysWithObject:);
    SEL overrideSelector = @selector(error_added_importValuesForKeysWithObject:);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
    
//    originalSelector = @selector(MR_importValuesForKeysWithObject:);
//    overrideSelector = @selector(error_added_importValuesForKeysWithObject:);
//    originalMethod = class_getInstanceMethod(self, originalSelector);
//    overrideMethod = class_getInstanceMethod(self, overrideSelector);
//    method_exchangeImplementations(originalMethod, overrideMethod);
}

- (BOOL) error_added_importValuesForKeysWithObject:(id)objectData
{
    self.errorsOnLastImport = [NSMutableArray new];
    BOOL worked = [self error_added_importValuesForKeysWithObject:objectData];
    if (!worked) {
        NSLog(@"[importValuesForKeysWithObject] did not work, you find errors in .errorsOnLastImport property of the NSObject: %@", [[self class] description]);
    }
    return worked;
}


#pragma mark ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - EXPORT DICTIONARY FROM CD
// -----------------------------------------------------------------------------
// EXPORT DICTIONARY FROM CD

- (NSMutableDictionary *)dictRepresentation
{
    return [self dictRepresentationIncludeSubentities:YES];
}

- (NSMutableDictionary *)dictRepresentationIncludeSubentities:(BOOL)includeSubentities
{
    NSMutableArray* visitedObjectIDs = [[NSMutableArray alloc] init];
    NSMutableArray* relationshipsToIgnore = [[NSMutableArray alloc] init];
    NSMutableDictionary *exportedDict = [self dictRepresentationIncludeSubentities:includeSubentities
                                                                  visitedObjectIDs:visitedObjectIDs
                                                             relationshipsToIgnore:relationshipsToIgnore];
    
    return exportedDict;
}

- (NSMutableDictionary *)dictRepresentationIncludeSubentities:(BOOL)includeSubentities
                                             visitedObjectIDs:(NSMutableArray *)visitedObjectIDs
                                        relationshipsToIgnore:(NSMutableArray *)relationshipsToIgnore
{
    NSMutableDictionary *resultDictionary = [self exportCompleteObjectManually];
    if (resultDictionary != nil) {
        [visitedObjectIDs addObject:self.objectID];
        return resultDictionary;
    }
    
    NSDictionary *attributes = [[self entity] attributesByName];
    NSMutableArray *keys = [[attributes allKeys] mutableCopy];
    
    [self removeKeysToIgnore:keys forAttributes:attributes];
    
    resultDictionary = [self exportAttributes:keys];
    
    // @FIXME: this is a side effect! convert NSDates if a dateFormat is given: either add aparameter for that, or do it somehow later or what
    [self convertNSDatesInResultDictionary:resultDictionary
                             forAttributes:attributes];
    
    [self mapKeysForKeys:keys
      inResultDictionary:resultDictionary
           forAttributes:attributes];
    
    resultDictionary = [resultDictionary mutableCopyWithoutNullValues];
    
    [visitedObjectIDs addObject:self.objectID];
    
    if (includeSubentities) {
        [self addRelationshipsToRequestDictionary:resultDictionary
                                 visitedObjectIDs:visitedObjectIDs
                            relationshipsToIgnore:relationshipsToIgnore];
    }

    [self didExportToDictionary:resultDictionary];

    return resultDictionary;
}


- (void)addRelationshipsToRequestDictionary:(NSMutableDictionary*)dict
                           visitedObjectIDs:(NSMutableArray *)visitedObjectIDs
                      relationshipsToIgnore:(NSMutableArray *)relationshipsToIgnore
{
    NSDictionary *relationships = [[self entity] relationshipsByName];
    
    NSArray *keys = [relationships allKeys];
    for (NSString *key in keys) {        
        NSRelationshipDescription *relationship = [relationships objectForKey:key];
        if ([relationshipsToIgnore containsObject:relationship]) { // avoid inverse relationships
            //NSLog(@"inverse ignored");
            continue;
        }
        if ([self ignoreKey:key userInfo:[relationship userInfo]]) {
            continue;
        }
        [self addInverseRelationship:relationship toIgnoreList:relationshipsToIgnore];
        
        [self exportRelationship:relationship
              inResultDictionary:dict
           relationshipsToIgnore:relationshipsToIgnore
                visitedObjectIDs:visitedObjectIDs
                          forKey:key];
    }
}


- (void)didExportToDictionary:(NSMutableDictionary *)dict
{
    // default does nothing, overwrite for notifications when export is finished
}

// ----------------------------- ATTRIBUTE HELPER ------------------------------
#pragma mark - ATTRIBUTE HELPER

- (NSMutableDictionary *)exportAttributes:(NSMutableArray *)keys
{
    NSMutableDictionary *firstExport = [self exportKeysPerHooks:keys];
    NSMutableDictionary *resultDictionary = [[self dictionaryWithValuesForKeys:keys] mutableCopy];
    
    [resultDictionary addEntriesFromDictionary:firstExport];
    return resultDictionary;
}

- (void)removeKeysToIgnore:(NSMutableArray *)keys
             forAttributes:(NSDictionary *)attributes
{
    NSMutableArray *keysToIgnore = [[NSMutableArray alloc] init];
    
    for (NSString *key in keys) {
        NSAttributeDescription *attribute = [attributes objectForKey:key];
        if ([self ignoreKey:key userInfo:[attribute userInfo]]) {
            [keysToIgnore addObject:key];
        }
    }
    [keys removeObjectsInArray:keysToIgnore];
}

- (NSMutableDictionary *)exportKeysPerHooks:(NSMutableArray *)keys
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [self exportKeysPerHooks:keys intoResultDictionary:dict];
    
    return dict;
}

- (void)mapKeysForKeys:(NSMutableArray *)keys
    inResultDictionary:(NSMutableDictionary *)resultDictionary
         forAttributes:(NSDictionary *)attributes
{
    NSMutableDictionary *keysToReplace = [[NSMutableDictionary alloc] init];
    for (NSString *key in keys) {
        NSAttributeDescription *attribute = [attributes objectForKey:key];
        NSString *lookupKey = [self mappedKeyForAttribute:attribute];
        if (![lookupKey isEqual:key]) {
            [keysToReplace setValue:lookupKey forKey:key];
        }
    }
    
    for (NSString *keyToReplace in keysToReplace) {
        id value = [resultDictionary objectForKey:keyToReplace];
        if (value) {
            [resultDictionary removeObjectForKey:keyToReplace];
            [resultDictionary setValue:value forKey:[keysToReplace objectForKey:keyToReplace]];
        }
    }
}

- (void)exportKeysPerHooks:(NSMutableArray *)keys
      intoResultDictionary:(NSMutableDictionary *)resultDictionary
{
    NSMutableArray *keysToIgnore = [[NSMutableArray alloc] init];
    
    for (NSString *key in keys) {
        if ([self MR_exportValueToDictionary:resultDictionary forKey:key]) {
            [keysToIgnore addObject:key];
        }
    }
    [keys removeObjectsInArray:keysToIgnore];
}

// ---------------------------- RELATIONSHIP HELPER ----------------------------
#pragma mark - RELATIONSHIP HELPER

- (void)addInverseRelationship:(NSRelationshipDescription *)relationship
                  toIgnoreList:(NSMutableArray *)relationshipsToIgnore
{
    if ([relationship inverseRelationship] && ((NSNull*)[relationship inverseRelationship] != [NSNull null] )) {
        [relationshipsToIgnore addObject:[relationship inverseRelationship]];
    }
}

- (void)exportRelationship:(NSRelationshipDescription *)relationship
        inResultDictionary:resultDictionary
     relationshipsToIgnore:(NSMutableArray *)relationshipsToIgnore
          visitedObjectIDs:(NSMutableArray *)visitedObjectIDs
                    forKey:(NSString *)key
{
    NSString *lookupKey = [self mappedKeyForRelationship:relationship];
    
    if ([self MR_exportValueToDictionary:resultDictionary forKey:lookupKey]) {
        return;
    }
    
    NSObject *subentityExported = [self exportSubentityOfKey:key
                                             forRelationship:relationship
                                            visitedObjectIDs:visitedObjectIDs
                                       relationshipsToIgnore:relationshipsToIgnore];
    [resultDictionary setValue:subentityExported forKey:lookupKey];
}

// ------------------------ EXPORT SINGLE OBJECT HELPER ------------------------
#pragma mark - EXPORT SINGLE OBJECT HELPER

- (NSMutableDictionary *)exportCompleteObjectManually
{
    if ([self respondsToSelector:@selector(exportToDictionary:)]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        if ([self performSelector:@selector(exportToDictionary:) withObject:dict]) {
            return dict;
        }
    }
    return nil;
}

- (NSObject *)exportSubentityOfKey:(NSString *)key
                   forRelationship:(NSRelationshipDescription *)relationship
                  visitedObjectIDs:(NSMutableArray *)visitedObjectIDs
             relationshipsToIgnore:(NSMutableArray *)relationshipsToIgnore
{
    id subentity = [self valueForKey:key];
    NSDictionary *subDict = nil;
    
    if ([subentity isKindOfClass:[NSManagedObject class]]) {
        subDict = [self exportNSManagedObject:subentity
                             visitedObjectIDs:visitedObjectIDs
                        relationshipsToIgnore:relationshipsToIgnore];
        return subDict;
    }
    else if ([relationship isToMany]) {
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:[subentity count]];
        for (id sub in subentity) {
            if ([sub isKindOfClass:[NSManagedObject class]]) {
                subDict = [self exportNSManagedObject:sub
                                     visitedObjectIDs:visitedObjectIDs
                                relationshipsToIgnore:relationshipsToIgnore];
                [results addObject:subDict];
            }
            else
            {
                NSLog(@"this should not happen, since we only include relationships here, not attribute");
            }
        }
        return results;
    }
    else
    {
        NSLog(@"this should not happen, since we only include relationships here, not attribute");
        return nil;
    }
}

- (NSDictionary *)exportNSManagedObject:(NSManagedObject *)subObject
                       visitedObjectIDs:(NSMutableArray *)visitedObjectIDs
                  relationshipsToIgnore:(NSMutableArray *)relationshipsToIgnore
{
    if ([visitedObjectIDs containsObject:subObject.objectID]) { // avoid indirect cycles
        NSLog(@"cycle detected");
        return nil;
    }
    return [subObject dictRepresentationIncludeSubentities:YES
                                          visitedObjectIDs:visitedObjectIDs
                                     relationshipsToIgnore:relationshipsToIgnore];
}

- (BOOL) MR_exportValueToDictionary:(id)value forKey:(NSString *)key
{
    NSString *selectorString = [NSString stringWithFormat:@"export%@:", [key MR_capitalizedFirstCharacterString]];
    SEL selector = NSSelectorFromString(selectorString);
    if ([self respondsToSelector:selector])
    {
        return [self performSelector:selector withObject:value];
    }
    return NO;
}

// -------------------------------- KEY HELPER ---------------------------------
#pragma mark - KEY HELPER

- (NSString *)mappedKeyForAttribute:(NSAttributeDescription *)attribute
{
    return [self mappedKeyWithOriginalKey:[attribute name] userInfo:[attribute userInfo]];
}

- (NSString *)mappedKeyForRelationship:(NSRelationshipDescription *)relationship
{
    return [self mappedKeyWithOriginalKey:[relationship name] userInfo:[relationship userInfo]];
}

- (NSString *)mappedKeyWithOriginalKey:(NSString *)originalKey userInfo:(NSDictionary *)userInfo
{
    
    
    NSString *skipMeaning = [[[self entity] userInfo] valueForKey:@"meaningOfSkip"];
    BOOL useSkipName = NO;
    if ([skipMeaning isEqualToString:@"useSkipName"]) {
        useSkipName = YES;
    }
    
    NSString *lookupKey = [self rawMappedKeyForUserInfo:userInfo] ?: originalKey;
    
    if ([self isSkipKey:lookupKey] && !useSkipName) {
        return originalKey; // ignore that here
    }
    return lookupKey;
}

// only mapped key or nil...
- (NSString *)rawMappedKeyForUserInfo:(NSDictionary *)userInfo
{
    NSString *lookupKey = nil;
    if ([userInfo valueForKey:@"exportMappedKeyName"]) {
        lookupKey = [userInfo valueForKey:@"exportMappedKeyName"];
    }
    else {
        lookupKey = [userInfo valueForKey:kMagicalRecordImportAttributeKeyMapKey] ?: nil;
    }
    return lookupKey;
}

- (BOOL) ignoreKey:(NSString *)key userInfo:(NSDictionary *)userInfo
{
    if ([[userInfo valueForKey:@"ignoreOnExport"] boolValue]) {
        return YES;
    }
    
    NSString *skipMeaning = [userInfo valueForKey:@"meaningOfSkip"];
    BOOL useAttributeIfSkipTagFound = NO;
    if ([skipMeaning isEqualToString:@"useAttributeIfSkipTagFound"]) {
        useAttributeIfSkipTagFound = YES;
    }
    if (!useAttributeIfSkipTagFound) {
        NSString *lookupKey = [self rawMappedKeyForUserInfo:userInfo];
        return [self isSkipKey:lookupKey];
    }
    return NO;
}

- (BOOL) isSkipKey:(NSString*)key
{
    return [[key lowercaseString] isEqualToString:@"skip"];
}

// --------------------------- MISCALLENIOUS HELPER ----------------------------
#pragma mark - MISCALLENIOUS HELPER

- (void)convertNSDatesInResultDictionary:(NSMutableDictionary *)resultDictionary
                           forAttributes:(NSDictionary *)attributes
{
    NSArray *keys = [resultDictionary allKeys];
    for (NSString *key in keys) {
        NSAttributeDescription *attribute = [attributes objectForKey:key];
        id value = [resultDictionary objectForKey:key];
        if ([value isKindOfClass:[NSDate class]]) {
            NSString *dateFormat = [[attribute userInfo] valueForKey:@"dateFormat"];
            if (!isEmptyOrNil(dateFormat)) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:dateFormat];
                value = [formatter stringFromDate:value];
                [resultDictionary setValue:value forKey:key];
            }
        }
    }
}

- (NSMutableDictionary *)changedValuesMutable
{
    NSMutableDictionary* changedValues = [[NSMutableDictionary alloc] init];
    for (NSString* key in [[self changedValuesForCurrentEvent] allKeys]) {
        
        if ([key isEqualToString:@"related"] ||
            [key isEqualToString:@"relatesFrom"]) {
            continue;
        }
        
        id value = [self valueForKey:key];
        if (!value) {
            value = [NSNull null];
        }
        
        [changedValues setObject:value
                          forKey:key];
    }
    return changedValues;
}

@end
