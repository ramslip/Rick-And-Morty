//
//  RMLocation.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMLocation.h"

@implementation RMLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id" : @"id",
             @"residentsUrlStrings" : @"residents",
             @"urlString" : @"url",
             };
}

@end
