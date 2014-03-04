//
//  KSExportable.h
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

/**
 *  Simple protocol that defines a method to export the receiver to a dictionary,
 *  which must in turn be JSON-exportable.
 *  This means, that any value set for a key *must* be serializable by the built-in
 *  JSON serializer (see `NSJSONSerialization` for more information).
 */
@protocol KSExportable <NSObject>

/**
 *  Tells the receiver to export itself into a JSON-serializable dictionary.
 *  Only primitive types may be used (including `NSString`, `NSNumber`, `NSArray`, `NSDictionary`, but *not* `NSDate`)
 *  as values in the resulting dictionary.
 *
 *  @return The resulting dictionary or nil if export failed.
 */
- (NSDictionary *)dictRepresentation;

@end
