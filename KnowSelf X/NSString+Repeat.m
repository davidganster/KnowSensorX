//
//  NSString+Repeat.m
//  KnowSensor X
//
//  Created by Joerg Simon on 12/5/12.
//
//

#import "NSString+Repeat.h"

BOOL isEmptyOrNil(NSString *str) {
    if (str == nil) {
        return YES;
    }
    return [str isEmpty];
}

@implementation NSString (Addons)

- (NSString *)repeatTimes:(NSUInteger)times {
    return [@"" stringByPaddingToLength:times * [self length] withString:self startingAtIndex:0];
}

- (NSArray *)splitByWhitespace {
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)normalizedString
{
    NSArray *components = [self normalizedComponents];
    NSString *norm = [components componentsJoinedByString:@""];
    // convert to ASCII only
    NSString *asciiString = [[NSString alloc] initWithData:[norm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
    return asciiString;
}

- (NSString *)stringByRemovingAllStrings:(NSString *)substringToRemove
{
    NSArray *components = [self componentsSeparatedByString:substringToRemove];
    NSString *newStr = [components componentsJoinedByString:@""];
    return newStr;
}

- (BOOL)containsSubstring:(NSString*)testStr
{
    if ([self rangeOfString:testStr].location == NSNotFound) {
        return NO;
    }
    return YES;

}

- (NSArray *)normalizedSearchComponents
{
    return [self normalizedComponentsForSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];
}

- (NSArray *)normalizedComponents
{
    return [self normalizedComponentsForSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSArray *)normalizedComponentsForSet:(NSCharacterSet*)characterSet
{
    NSString *lower = [[self trim] lowercaseString];
    NSArray *components = [lower componentsSeparatedByCharactersInSet:characterSet];
    return components;
}

- (BOOL)isEmpty {
    if (!self) {
        return YES;
    }
    
    if([self length] == 0) { //string is empty or nil
        return YES;
    }
    
    if (self == (NSString*)[NSNull null]) {
        return YES;
    }
    
    NSString *timmedself = [self trim];
    if([timmedself length] == 0) {
        //string is all whitespace
        return YES;
    }
    
    if ([timmedself isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

@end
