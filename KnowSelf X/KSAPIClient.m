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
            NSLog(@"ERROR: unknown event type %i (Event = %@).", event.type, event);
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
/// Should not be called from outside, use the convenience-wrappers (e.g. sendIdleStartEvent:finished:) instead
- (void)uploadEvent:(KSEvent *)event
             toPath:(NSString *)path
           finished:(void (^)(NSError *error))finishedBlock
{
    if(!event || !path) {
        NSLog(@"Need both event and path to be not nil when sending data!");
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
    
    
    NSLog(@"jsonString = %@", [[NSString alloc] initWithData:dictAsNSData encoding:NSUTF8StringEncoding]);
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"yay!");
        finishedBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"oh no :(");
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
        //[self testCall];
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


#pragma mark DEBUG

- (void)testCall
{
    NSDictionary *dataFieldDict = @{
                                    @"path":@"file://C:/Repository/KnowSe/branches/Focus_Event_With_Screenshots_Integration/server/events/src/test/resources",
                                    @"processid":@(3956),
                                    @"processname":@"explorer",
                                    @"runtimeid":@(171204624),
                                    @"screenshot":[NSNull null],
                                    @"timestamp":@"/Date(1336912505824+0200)/",
                                    @"windowhandle":@(171204624),
                                    @"windowtitle":@"resources"
                                    };
    NSData *jsonEncodedDataField = [NSJSONSerialization dataWithJSONObject:dataFieldDict
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:nil];
    
    NSString *base64EncodedDataField = [jsonEncodedDataField encodeBase64WithNewlines:NO];
    
    NSDictionary *generalDataDict = @{
                                      @"application":@"RawCap",
                                      @"data": base64EncodedDataField,
                                      @"deviceid":@"OpenSourceDeviceId",
                                      @"sensorid":@"Focus Sensor",
                                      @"timestamp":@"2013-08-20T12:47:13.0896458Z",
                                      @"type":@"applicationDidLoseFocus",
                                      @"userid":@"OpenSourceUserId"
                                      };
    
    NSData *generalDataDictAsData = [NSJSONSerialization dataWithJSONObject:generalDataDict
                                                                    options:NSJSONWritingPrettyPrinted
                                                                      error:nil];
    
    
    NSString *path = @"events/applicationDidLoseFocus";
    NSMutableURLRequest *request = [self.client requestWithMethod:@"POST" path:path parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [request setHTTPBody:generalDataDictAsData];
    
    NSLog(@"jsonString = %@", [[NSString alloc] initWithData:generalDataDictAsData encoding:NSUTF8StringEncoding]);
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"yay!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"oh no :(");
    }];
    
    [self.client enqueueHTTPRequestOperation:requestOperation];
}

@end
