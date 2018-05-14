//
//  RMAPIClient+Character.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMAPIClient.h"

@interface RMAPIClient (Character)

- (void)getAllCharactersOnPage:(NSUInteger)page
                   WithSuccess:(RMAPIClientSuccessBlock)success
                       failure:(RMAPIClientFailureBlock)failure;

@end
