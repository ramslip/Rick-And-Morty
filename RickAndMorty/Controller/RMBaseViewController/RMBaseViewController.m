//
//  RMBaseViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 24.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseViewController.h"

@implementation RMBaseViewController

+ (NSString *)controllerIdentifier {
    return NSStringFromClass([self class]);
}

@end
