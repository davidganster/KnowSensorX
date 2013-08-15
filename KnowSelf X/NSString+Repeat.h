//
//  NSString+Repeat.h
//  KnowSensor X
//
//  Created by Joerg Simon on 12/5/12.
//
//

#import <Foundation/Foundation.h>

BOOL isEmptyOrNil(NSString *str);

@interface NSString (Addons)

- (NSString *)repeatTimes:(NSUInteger)times;
- (NSArray *)splitByWhitespace;
- (NSString *)trim;
- (NSString *)normalizedString;
- (NSString *)stringByRemovingAllStrings:(NSString *)substringToRemove;
- (BOOL)containsSubstring:(NSString*)testStr;
- (NSArray *)normalizedSearchComponents;
- (NSArray *)normalizedComponents;
- (BOOL)isEmpty;

@end

