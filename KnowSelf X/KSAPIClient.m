//
//  KSAPIClient.m
//  KnowSensor X
//
//  Created by David Ganster on 19/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSAPIClient.h"
#import "AFNetworking.h"
#import "NSData-Base64Extensions.h"
#import "NSManagedObject+Addons.h"
#import "KSUserInfo.h"
#import "KSEvent+Addons.h"
#import "KSProject+Addons.h"
#import "KSActivity+Addons.h"

@interface KSAPIClient ()

@property(nonatomic, strong) AFHTTPClient *client;

@end

@implementation KSAPIClient

+ (KSAPIClient *)sharedClient
{
    static KSAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KSAPIClient alloc] init];
    });
    
    return _sharedClient;
}


- (void)loadProjectsWithSuccess:(void(^)(NSArray *projects))success
                        failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"mirror/KCProjects" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *jsonParseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:0
                                                          error:&jsonParseError];
        if(!jsonParseError && [jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *projectDicts = (NSArray *)jsonObject;
            NSMutableArray *projects = [NSMutableArray array];
            for (NSDictionary *projectDict in projectDicts) {
                KSProject *project = [KSProject createOrFetchWithData:projectDict
                                                            inContext:[NSManagedObjectContext defaultContext]];
                if(project) {
                    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Successfully imported project from \n%@\n", projectDict);
                    [projects addObject:project];

                } else {
                    LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Could not import project from \n%@\n", projectDict);
                }
            }
            
            // after having created all the objects, save them and then call the success/failure blocks:
            [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL saveSuccessful, NSError *error) {
                // the saveSuccessful flag is not reliable as it will be set to NO if ANY of the parent contexts have no changes!
                // better to check the error pointer instead:
                if(!error) {
                    success(projects);
                } else {
                    failure(error);
                }
            }];
        } else {
            LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Did not get valid json object from server:\n%@\n", jsonObject);
            failure(jsonParseError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

- (void)loadActiveActivity:(void(^)(KSActivity *currentActivity))success
                   failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"mirror/KCActivities" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *jsonParseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:0
                                                          error:&jsonParseError];
        
        if(!jsonParseError && [jsonObject isKindOfClass:[NSDictionary class]]) {
            KSActivity *activity = [KSActivity createOrFetchWithData:jsonObject
                                                           inContext:[NSManagedObjectContext defaultContext]];
            if(activity) {
                LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"Successfully imported activity from \n%@\n", responseObject);
            } else {
                LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Could not import activity from \n%@\n", responseObject);
            }
            // after having created all the objects, save them and then call the success/failure blocks:
            [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL saveSuccessful, NSError *error) {
                // the saveSuccessful flag is not reliable as it will be set to NO if ANY of the parent contexts have no changes!
                // better to check the error pointer instead:
                if(!error) {
                    success(activity);
                } else {
                    failure(error);
                }
            }];
        } else {
            LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Did not get valid json object from server:\n%@\n", jsonObject);
            failure(jsonParseError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"CreateProject successful.");
        NSError *jsonError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
        if(!jsonError && [responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *newProjectID = [responseDict objectForKey:@"id"];
            success(newProjectID);
        } else {
            success(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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

    NSDictionary *activityDict = [activity dictRepresentation];
    
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
        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StartRecordingActivity successful.");
        NSError *jsonError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
        if(!jsonError && [responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *newActivityID = [responseDict objectForKey:@"id"];
            success(newActivityID);
        } else {
            failure(jsonError); // maybe success because it technically worked?
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"StartRecordingActivity FAILED with error: %@.", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];

}


- (void)stopRecordingActivity:(KSActivity *)activity
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"mirror/KCActivities/@%@", activity.activityID];
    NSMutableURLRequest *request = [self.client requestWithMethod:@"PUT" path:path parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSDictionary *activityDict = [activity dictRepresentation];
    
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
        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"StopRecordingActivity successful.");
        NSError *jsonError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
        if(!jsonError && [responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *newActivityID = [responseDict objectForKey:@"id"];
            success(newActivityID);
        } else {
            failure(jsonError); // maybe success because it technically worked?
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"StopRecordingActivity FAILED with error: %@.", error);
        failure(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

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
/// Should not be called from outside, use the convenience-wrappers (e.g. sendEvent:finished: or more specifically, e.g.  sendIdleStartEvent:finished:) instead
- (void)uploadEvent:(KSEvent *)event
             toPath:(NSString *)path
           finished:(void (^)(NSError *error))finishedBlock
{
    if(!event || !path) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelDebug, @"Need both event and path to be not nil when sending data!");
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
    
    
    LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"jsonString = %@", [[NSString alloc] initWithData:dictAsNSData
                                                                                              encoding:NSUTF8StringEncoding]);
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelInfo, @"yay!");
        finishedBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LogMessage(kKSLogTagAPIClient, kKSLogLevelError, @"Sending message to server failed with error: %@", error);
        finishedBlock(error);
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

#pragma mark Really Private - DO NOT CALL THESE METHODS FROM OUTSIDE!

- (id)init
{
    self = [super init];
    if(self) {
        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kKSServerBaseURL]];
    }
    return self;
}

#pragma mark Helper

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
