//
//  KSAPIClient.m
//  KnowSensor X
//
//  Created by David Ganster on 19/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSAPIClient.h"
#import "AFNetworking.h"
#import "KSGlobals.h"
#import "NSData+Base64.h"
#import "NSData-Base64Extensions.h"
#import "AFJSONUtilities.h"

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

- (id)init
{
    self = [super init];
    if(self) {
        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kKSServerBaseURL]];
        [self testCall];
    }
    return self;
}

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
