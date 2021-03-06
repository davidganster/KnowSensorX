//
//  KSIdleEvent.h
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
#import "KSEvent.h"

/**
 *  Describes an idle event to be sent to the server.
 *  Mirrors the data model on the KnowServer.
 */
@interface KSIdleEvent : KSEvent

/// Shows how long the user is already idle at the time of sending the event.
/// For an KSEventTypeIdleStart event, this is the currently set idle time, for the KSEventTypeIdleEnd,
/// this will be timeOfRecording - idleSinceTimestamp.
@property (nonatomic, retain) NSNumber * idleSinceSeconds;
/// The timestamp when the user entered the idle-state.
@property (nonatomic, retain) NSDate * idleSinceTimestamp;
/// The timestamp when the event is recorded. Same as timestamp in the KSEvent, but required by the server.
@property (nonatomic, retain) NSDate * timeOfRecording;

@end
