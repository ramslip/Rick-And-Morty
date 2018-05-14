//
//  RMAPIClient+Location.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMAPIClient.h"

@interface RMAPIClient (Location)

- (void)getLocationsOnPage:(NSUInteger)page
               WithSuccess:(RMAPIClientSuccessBlock)success
                   failure:(RMAPIClientFailureBlock)failure;

@end
