//
//  RMAPIClient+Character.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMAPIClient+Character.h"
#import "RMAPIClient_Private.h"
#import "RMCharacter.h"

@implementation RMAPIClient (Character)

- (void)getAllCharactersOnPage:(NSUInteger)page
                   WithSuccess:(RMAPIClientSuccessBlock)success
                            failure:(RMAPIClientFailureBlock)failure {
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" operation:@"" data:nil path:[NSString stringWithFormat:@"character/?page=%lu", (unsigned long)page]];
    [self enqueueRequest:request resultClass:[RMCharacter class] rootKey:@"results" success:success failure:failure];
}

@end
