//
//  RMAPIClient_Private.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#ifndef RMAPIClient_Private_h
#define RMAPIClient_Private_h

#import "RMAPIClient.h"

@interface RMAPIClient ()

+ (NSArray *)importJSONArray:(NSArray *)JSONArray resultClass:(Class)class;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method operation:(NSString *)operation data:(NSDictionary *)data path:(NSString *)path;

- (void)authorizeRequest:(NSURLRequest *)request
                 success:(void (^)(id resultObject))success
                 failure:(void (^)(NSError *))failure;

- (void)enqueueRequest:(NSURLRequest *)request
           resultClass:(Class)resultClass
               rootKey:(NSString *)keyPath
               success:(void (^)(id resultObject))success
               failure:(void (^)(NSError *))failure;

- (void)enqueueRequest:(NSURLRequest *)request
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

@end

#endif /* RMAPIClient_Private_h */
