//
//  RMAPIClient.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMAPIClient.h"
#import <MTLJSONAdapter.h>
#import <SIALogger.h>

static NSString * const RMAPIClientBaseUrl = @"https://rickandmortyapi.com/api/";

@interface RMAPIClient()

@property (copy, nonatomic) NSDictionary *errors;

@end

@implementation RMAPIClient

+ (instancetype)sharedClient {
    static RMAPIClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[RMAPIClient alloc] initWithBaseURL:[NSURL URLWithString:RMAPIClientBaseUrl]];
    });
    return client;
}

- (NSDictionary *)errors {
    if (!_errors) {
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Errors" ofType:@"plist"]];
        _errors = dictionary;
    }
    return _errors;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    return self;
}

#pragma mark - Private methods

+ (NSArray *)importJSONArray:(NSArray *)JSONArray resultClass:(Class)class {
    if (!JSONArray || [JSONArray isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSMutableArray *mappedObjects = [NSMutableArray array];
    for (NSDictionary *dataObject in JSONArray) {
        [mappedObjects addObject:[MTLJSONAdapter modelOfClass:class fromJSONDictionary:dataObject error:nil]];
    }
    return [mappedObjects copy];
}

- (void)authorizeRequest:(NSURLRequest *)request
                 success:(void (^)(id resultObject))success
                 failure:(void (^)(NSError *))failure {
    [self enqueueRequest:request resultClass:nil rootKey:nil success:success failure:failure];
}

- (void)enqueueRequest:(NSURLRequest *)request
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    [self enqueueRequest:request resultClass:nil rootKey:nil success:success failure:failure];
}

- (void)enqueueRequest:(NSURLRequest *)request
           resultClass:(Class)resultClass
               success:(void (^)(id resultObject))success
               failure:(void (^)(NSError *))failure {
    [self enqueueRequest:request resultClass:nil rootKey:nil success:success failure:failure];
}

- (void)enqueueRequest:(NSURLRequest *)request
           resultClass:(Class)resultClass
               rootKey:(NSString *)keyPath
               success:(void (^)(id resultObject))success
               failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSString *body = [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] stringByRemovingPercentEncoding];
        SIALogInfo(@"\n⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣\n"
                   @"🔸   Request:\n%@\n"
                   @"🔸   Request body:\n%@\n"
                   @"🔸   Class: %@\n"
                   @"🔸   Response:\n%@\n"
                   @"⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡\n\n", request, body, resultClass, responseObject);
#endif
        @try {
            NSDictionary *successState = responseObject;
            if (successState) {
                id result = successState;
                
                id objectToParse = keyPath ? [result valueForKeyPath:keyPath] : result;
                if (objectToParse && ![objectToParse isEqual:[NSNull null]]) {
                    if (resultClass) {
                        if ([objectToParse isKindOfClass:[NSArray class]]) {
                            if (success) {
                                success([self.class importJSONArray:objectToParse resultClass:resultClass]);
                            }
                        } else if ([objectToParse isKindOfClass:[NSDictionary class]]) {
                            if (success) {
                                success([MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:objectToParse error:nil]);
                            }
                        }
                    } else {
                        if (success) {
                            success(objectToParse);
                        }
                    }
                } else {
                    if (success) {
                        success(responseObject);
                    }
                }
            } else {
                if (failure) {
                    NSString *errorCode = responseObject[@"error"][@"code"];
                    if (errorCode) {
                        NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey: errorCode}];
                        NSString *errorMsg = self.errors[errorCode];
                        failure(error);
                        if (errorMsg.length) {
                            //[SVProgressHUD showErrorWithStatus:errorMsg];
                            NSLog(@"%@", errorMsg);
                        }
                    } else {
                        //NSString *message = [StringsHelper stringForKey:@"title.error"];
                        NSArray *errors = responseObject[@"error"][@"errors"];
                        if (errors.count) {
                            NSArray *messagesArray = [errors valueForKeyPath:@"@distinctUnionOfObjects.text"];
                            if (messagesArray.count) {
                                
                            }
                                //message = [messagesArray componentsJoinedByString:@"\n\n"];
                        }
                        //[SVProgressHUD showErrorWithStatus:message];
                    }
                }
            }
        }
        @catch (NSException * e) {
            //[SVProgressHUD showErrorWithStatus:e.description];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == -1009) {
            //[SVProgressHUD showErrorWithStatus:[StringsHelper stringForKey:@"network.error.connection"]];
        } else if (error.code == -1012 || error.code == -1011) {
           // [SVProgressHUD showErrorWithStatus:[StringsHelper stringForKey:@"network.error.server"]];
        }
        if (failure) {
            failure(error);
        }
#ifdef DEBUG
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSString *body = [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] stringByRemovingPercentEncoding];
        
        SIALogInfo(@"\nE R R O R     ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣ ⇣\n"
                   @"🔸   Request body:\n%@\n"
                   @"⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡ ⇡\n\n", body);
#endif
    }];
    
    [self.operationQueue addOperation:operation];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method operation:(NSString *)operation data:(NSDictionary *)data path:(NSString *)path {
    return [self requestWithMethod:method path:path operation:operation data:data];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path operation:(NSString *)operation data:(NSDictionary *)data {
    return [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:nil error:nil];
}

@end
