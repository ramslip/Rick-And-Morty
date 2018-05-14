//
//  RMAPIClient.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^RMAPIClientSuccessBlock)(id result);
typedef void(^RMAPIClientFailureBlock)(NSError *error);

@interface RMAPIClient : AFHTTPRequestOperationManager 

+ (instancetype)sharedClient;

@end
