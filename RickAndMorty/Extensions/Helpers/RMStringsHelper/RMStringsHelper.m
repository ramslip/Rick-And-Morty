//
//  RMStringsHelper.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMStringsHelper.h"

static NSString * const RMStringsHelperFileName = @"strings";

@implementation RMStringsHelper

+ (NSString *)stringForKey:(NSString *)key {
    return NSLocalizedStringFromTable(key, RMStringsHelperFileName, nil);
}

@end
