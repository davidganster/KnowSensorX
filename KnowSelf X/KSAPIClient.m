//
//  KSAPIClient.m
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

#import "KSAPIClient.h"
#import "AFNetworking.h"
#import "NSData-Base64Extensions.h"
#import "KSUserInfo.h"
#import "KSEvent.h"
#import "KSProject.h"
#import "KSActivity.h"

@interface KSAPIClient ()

/// Private property for storing the shared instance's AFNetworking client.
@property(nonatomic, strong) AFHTTPClient *client;

/// Indicates if the API Client should continue to check for reachability on its own.
@property(nonatomic, assign) BOOL checkForReachability;

/**
 Private method that periodically checks reachability. Will send a notification when the notification status changes.
 @param interval Time to start the next check after receiving a response from the server.
 */
- (void)checkReachabilityWithTimeInterval:(NSTimeInterval)interval;

@end

@implementation KSAPIClient


#pragma mark Public Methods.
/// @name Public methods

+ (KSAPIClient *)sharedClient
{
    static KSAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KSAPIClient alloc] init];
    });
    
    return _sharedClient;
}

- (void)setServerReachable:(BOOL)serverReachable
{
    if(self.serverReachable && !serverReachable) {
        _serverReachable = serverReachable;
        [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyServerUnreachable
                                                            object:nil];
    } else if(!self.serverReachable && serverReachable) {
        _serverReachable = serverReachable;
        [[NSNotificationCenter defaultCenter] postNotificationName:kKSNotificationKeyServerReachable
                                                            object:nil];
    }
}

- (void)startCheckingForServerReachability
{
    self.checkForReachability = YES;
    [self checkReachabilityWithTimeInterval:0];
}

- (void)stopCheckingForServerReachability
{
    self.checkForReachability = NO;
}

#pragma mark - Project related calls
/// @name Project related calls
- (void)loadProjectsWithSuccess:(void(^)(NSArray *projects))success
                        failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"mirror/KCProjects" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // check if the server has been unreachable previously. If yes, the nowReachable-block will be executed.
        [self setServerReachable:YES];
        
        NSError *jsonParseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:0
                                                          error:&jsonParseError];
        if(!jsonParseError && [jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *projectDicts = (NSArray *)jsonObject;
            NSMutableArray *projects = [NSMutableArray array];
            for (NSDictionary *projectDict in projectDicts) {
                KSProject *project = [[KSProject alloc] init];
                if([project importValuesForKeysWithObject:projectDict]) {
//                    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Successfully imported project from \n%@\n", projectDict);
                    [projects addObject:project];

                } else {
                    LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Could not import project from \n%@\n", projectDict);
                }
            }
            success(projects);
        } else {
            LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Did not get valid json object from server:\n%@\n", jsonObject);
            failure(jsonParseError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

- (void)loadAllActivities:(void(^)(NSArray *activities))success
                  failure:(void (^)(NSError *error))failure
{
    NSString *now = [[KSUtils dateAsString:[NSDate date]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *past =[[KSUtils dateAsString:[NSDate distantPast]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET"
                                                             path:@"mirror/KCActivities"
                                                       parameters:@{
                                                                    @"start_date" : past,
                                                                    @"end_date"   : now}];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // running on the mainThread, do not need to performBlock: on the defaultContext?
        
        // check if the server has been unreachable previously. If yes, the nowReachable-block will be executed.
        [self setServerReachable:YES];
        
        NSError *jsonParseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:0
                                                          error:&jsonParseError];
        if(jsonParseError || [jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = (NSArray *)jsonObject;
            NSMutableArray *activities = [NSMutableArray array];
            for (NSDictionary *activityDict in responseArray) {
                // parse activities here
                KSActivity *activity = [[KSActivity alloc] init];
                if([activity importValuesForKeysWithObject:activityDict]) {
//                    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Successfully imported activity from \n%@\n", activityDict);
                    [activities addObject:activity];
                } else {
                    LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Could not import activity from \n%@\n", activityDict);
                }
            }
                    success(activities);
        } else {
            // Unexpected answer
            LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Received invalid JSON object: %@", jsonObject);
            failure(jsonParseError); // might pass nil in case the response was another class but parsing worked fine.
        }
        // TODO: parse json, create activity objects.
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];

}

- (void)loadActiveActivity:(void(^)(KSActivity *currentActivity))success
                   failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"mirror/KCActivities" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setServerReachable:YES];
        NSError *jsonParseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:0
                                                          error:&jsonParseError];
        
        if(!jsonParseError && [jsonObject isKindOfClass:[NSDictionary class]]) {
            KSActivity *activity = [[KSActivity alloc] init];
            if([activity importValuesForKeysWithObject:jsonObject]) {
//                LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Successfully imported activity from \n%@\n", jsonObject);
            } else {
                LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Could not import activity from \n%@\n", jsonObject);
            }
            success(activity);
        } else {
            if(jsonParseError) {
                LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Did not get valid json object from server:\n%@\n", jsonObject);
                failure(jsonParseError);
            } else {
                success(nil); // no objects.
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}


- (void)createProject:(KSProject *)project
              success:(void (^)(NSString *newProjectID))success
              failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:@"mirror/KCProjects" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSDictionary *projectDict = [project dictRepresentation];
    NSError *jsonSerializationError = nil;
    NSData *projectData = [NSJSONSerialization dataWithJSONObject:projectDict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&jsonSerializationError];
    if(jsonSerializationError) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"JSON Serialization failed for object %@ (%@)", projectDict, project);
        failure(jsonSerializationError);
        return;
    }

    [request setHTTPBody:projectData];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setServerReachable:YES];

//        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"CreateProject successful.");
        NSError *jsonError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
        if(!jsonError && [responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *newProjectID = [responseDict objectForKey:@"id"];
            success(newProjectID);
        } else {
            success(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"CreateProject FAILED with error: %@.", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}


- (void)startRecordingActivity:(KSActivity *)activity
                       success:(void (^)(NSString *newActivityID))success
                       failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:@"mirror/KCActivities" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
//    [activity setIsStartingRecording:NO];
    NSDictionary *activityDict = [activity dictRepresentation];
    
//    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StartRecordingActivity with dict representation: \n%@", activityDict);
    
    NSError *jsonSerializationError = nil;
    NSData *activityData = [NSJSONSerialization dataWithJSONObject:activityDict
                                                          options:NSJSONWritingPrettyPrinted
                                                            error:&jsonSerializationError];
    if(jsonSerializationError) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"JSON Serialization failed for object %@ (%@)", activityDict, activity);
        failure(jsonSerializationError);
        return;
    }
    
    [request setHTTPBody:activityData];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setServerReachable:YES];
//        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StartRecordingActivity successful.");
        NSError *jsonError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
        if(!jsonError && [responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *newActivityID = [responseDict objectForKey:@"id"];
            success(newActivityID);
        } else {
            failure(jsonError); // maybe success because it technically worked?
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"StartRecordingActivity FAILED with error: %@.", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}


- (void)stopRecordingActivity:(KSActivity *)activity
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"mirror/KCActivities/%@", activity.activityID];
    NSMutableURLRequest *request = [self.client requestWithMethod:@"PUT" path:path parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [activity setEndDate:[NSDate date]];

//    [activity setIsStartingRecording:NO];
    NSDictionary *activityDict = [activity dictRepresentation];
    
//    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StopRecordingActivity with dict representation: \n%@", activityDict);
    
    NSError *jsonSerializationError = nil;
    NSData *activityData = [NSJSONSerialization dataWithJSONObject:activityDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&jsonSerializationError];
    if(jsonSerializationError) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"JSON Serialization failed for object %@ (%@)", activityDict, activity);
        failure(jsonSerializationError);
        return;
    }
    
    [request setHTTPBody:activityData];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setServerReachable:YES];
//        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StopRecordingActivity successful.");
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"StopRecordingActivity FAILED with error: %@.", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}


#pragma mark Event related calls
/// @name Event related calls

- (void)sendEvent:(KSEvent *)event finished:(void (^)(NSError *error))block
{
    switch (event.type) {
        case KSEventTypeDidGetFocus:
            [self sendGetFocusEvent:event finished:block];
            break;
        case KSEventTypeDidLoseFocus:
            [self sendLoseFocusEvent:event finished:block];
            break;
        case KSEventTypeIdleStart:
            [self sendUserIdleStartEvent:event finished:block];
            break;
        case KSEventTypeIdleEnd:
            [self sendUserIdleEndEvent:event finished:block];
            break;
        default:
            LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Unknown event type %i (Event = %@).", event.type, event);
            break;
    }
}

- (void)sendGetFocusEvent:(KSEvent *)event finished:(void (^)(NSError *error))block
{
    [self uploadEvent:event toPath:kKSURLPathApplicationDidGetFocusPath finished:block];
}

- (void)sendLoseFocusEvent:(KSEvent *)event finished:(void (^)(NSError *error))block
{
    [self uploadEvent:event toPath:kKSURLPathApplicationDidLoseFocusPath finished:block];
}

- (void)sendUserIdleStartEvent:(KSEvent *)event finished:(void (^)(NSError *error))block
{
    [self uploadEvent:event toPath:kKSURLPathIdleDidStart finished:block];
}

- (void)sendUserIdleEndEvent:(KSEvent *)event finished:(void (^)(NSError *error))block
{
    [self uploadEvent:event toPath:kKSURLPathIdleDidEnd finished:block];
}


#pragma mark Psuedo-Private
/// @name Private methods

/**
 *  Initializes a new instance of KSAPIClient. Do not call this method, but use the
 *  singleton-accessor instead (`sharedClient`).
 *
 *  @return The newly initialized KSAPIClient object.
 */
- (id)init
{
    self = [super init];
    if(self) {
        NSString *serverBaseUrl = [[KSUserInfo sharedUserInfo] serverAddress];
        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:serverBaseUrl]];
        _serverReachable = NO;
    }
    return self;
}

/**
 *  Internal method, should not be called from outside, use the convenience-wrappers (e.g. sendEvent:finished: or more specifically, e.g.  sendIdleStartEvent:finished:) instead.
 *
 *  @param event         The event to be sent to the server. Must not be nil.
 *  @param path          The path to send the event to. Must not be nil.
 *  @param finishedBlock The block to invoke when the call returns. The block will receive a non-nil NSError object as parameter, should the call fail.
 */
- (void)uploadEvent:(KSEvent *)event
             toPath:(NSString *)path
           finished:(void (^)(NSError *error))finishedBlock
{
    if(!event || !path) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Need both event and path to be not nil when sending data!");
        NSError *error = [NSError errorWithDomain:@"EventOrPathNil" code:-101 userInfo:nil];
        finishedBlock(error);
        return;
    }
    
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:path parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    // serialize data:
    NSData *dictAsNSData = nil;
    NSError *jsonSerializationError = nil;
    NSDictionary *dict = [self dictionaryFromEvent:event
                                serializationError:&jsonSerializationError];
    
    
    if(!jsonSerializationError)
        dictAsNSData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&jsonSerializationError];
    
    if(jsonSerializationError) {
        finishedBlock(jsonSerializationError);
        return;
    }
    
    [request setHTTPBody:dictAsNSData];
    
    
//    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"jsonString = %@", [[NSString alloc] initWithData:dictAsNSData
//                                                                                              encoding:NSUTF8StringEncoding]);
//    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setServerReachable:YES];
        finishedBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setServerReachable:NO];
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        finishedBlock(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

- (void)checkReachabilityWithTimeInterval:(NSTimeInterval)interval
{
    NSString *testURL = [[self.client.baseURL absoluteString]
                         stringByAppendingString:@"/Resources/Images/btn_first_highlighted.png"];
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:testURL parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(!self.serverReachable) {
//            LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Server now reachable (detected when checking for reachability)!");
        }
        [self setServerReachable:YES];
        [self checkReachabilityWithTimeInterval:kKSAPIClientServerReachabilityPollIntervalServerUp];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(self.serverReachable) {
//            LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Server no longer reachable (detected when checking for reachability)!");
        }
        [self setServerReachable:NO];
        [self checkReachabilityWithTimeInterval:kKSAPIClientServerReachabilityPollIntervalServerDown];
    }];

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(self.checkForReachability) {
            [self.client enqueueHTTPRequestOperation:operation];
        }
    });
}

#pragma mark Helper
/// @name Helper
/**
 *  Helper method to export the given event into a representation that is recognized by the server.
 *  The result of the 'dictRepresentation' message sent to the event will be base64 encoded and 
 *  set for the 'data' key in the resulting dictionary.
 *
 *  @param event The event to be exported.
 *  @param error Pointer to the error that occurred during export. Nil if export went without problems.
 *
 *  @return The event, exported into a dictionary form that the server can parse (after being serialized to a JSON).
 */
- (NSDictionary *)dictionaryFromEvent:(KSEvent *)event serializationError:(NSError **)error
{
    // the data-field is represented by the exported object.
    NSDictionary *dataFieldDict = [event dictRepresentation];
    NSData *jsonEncodedDataField = [NSJSONSerialization dataWithJSONObject:dataFieldDict
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:error];
    
    if(*error)
        return nil;
    
    NSString *base64EncodedDataField = [jsonEncodedDataField encodeBase64WithNewlines:NO];
    
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    [resultDict setObject:base64EncodedDataField forKey:kKSJSONKeyData];
    
    [resultDict setObject:[[KSUserInfo sharedUserInfo] deviceID] forKey:kKSJSONKeyDeviceID];
    [resultDict setObject:[[KSUserInfo sharedUserInfo] userID]   forKey:kKSJSONKeyUserID];
    [resultDict setObject:event.sensorID                         forKey:kKSJSONKeySensorID];
    [resultDict setObject:[event timestampAsString]              forKey:kKSJSONKeyTimeStamp];
    [resultDict setObject:[event typeAsString]                   forKey:kKSJSONKeyType];
    [resultDict setObject:[event application]                    forKey:kKSJSONKeyApplication];
    
    return resultDict;
}

@end
