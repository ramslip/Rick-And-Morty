//
//  RMAPIClient+Location.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMAPIClient+Location.h"
#import "RMAPIClient_Private.h"
#import "RMLocation.h"

@implementation RMAPIClient (Location)

- (void)getLocationsOnPage:(NSUInteger)page
               WithSuccess:(RMAPIClientSuccessBlock)success
                   failure:(RMAPIClientFailureBlock)failure {
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" operation:@"" data:nil path:[NSString stringWithFormat:@"location/?page=%lu", (unsigned long)page]];
    [self enqueueRequest:request resultClass:[RMLocation class] rootKey:@"results" success:success failure:failure];
}


@end
