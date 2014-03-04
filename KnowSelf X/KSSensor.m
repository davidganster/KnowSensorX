//
//  KSSensor.m
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

#import "KSSensor.h"


@implementation KSSensor

- (id)initWithDelegate:(id<KSSensorDelegateProtocol>) delegate
{
    self = [super init];
    if(self) {
        _delegate = delegate;
    }
    
    return self;
}

- (BOOL)startRecordingEvents
{
    BOOL success = NO;
    if(self.isActive || // no need to start recording again
       (success = [self _registerForEvents]))
        [self setActive:YES];
    else {
        LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not register sensor '%@' for events!", self.name);
    }
    return success;
}


- (void)stopRecordingEventsFinished:(void (^)(BOOL successful))finished
{
    if(self.isActive) { // no need to stop recording again
        [self _unregisterForEventsFinished:^(BOOL successful) {
            if(successful) {
                [self setActive:NO];
            } else {
                LogMessage(kKSLogTagOther, kKSLogLevelError, @"ERROR: could not unregister sensor '%@' for events!", self.name);
            }
            finished(successful);
        }];
    }
}


- (void)dealloc
{
    if(self.isActive)
        [self _unregisterForEventsFinished:nil];
}

@end


@implementation KSSensor (SubclassingHooks)

- (BOOL)_registerForEvents
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'registerForEvents'.");
    return NO;
}

- (void)_unregisterForEventsFinished:(void (^)(BOOL))finished
{
    NSAssert(FALSE, @"Subclass needs to overwrite 'unregisterForEvents'.");
}

@end
