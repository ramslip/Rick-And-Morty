//
//  RMStoryboardHelper.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 24.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMStoryboardHelper.h"

static NSString * const RMStoryboardHelperMainStoryboardName = @"Main";

@implementation RMStoryboardHelper

+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:RMStoryboardHelperMainStoryboardName bundle:nil];
 }

@end
