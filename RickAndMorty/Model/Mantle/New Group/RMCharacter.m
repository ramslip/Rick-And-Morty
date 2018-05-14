//
//  RMCharacter.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMCharacter.h"

@implementation RMCharacter

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id" : @"id",
             @"originName" : @"origin.name",
             @"originUrlString" : @"origin.url",
             @"locationName" : @"location.name",
             @"locationUrlString" : @"location.url",
             @"imageUrlString" : @"image",
             @"episodesUrlStringsArray" : @"episode",
             @"urlString" : @"url",
             @"createdDataSrting" : @"created"
             };
}

@end
