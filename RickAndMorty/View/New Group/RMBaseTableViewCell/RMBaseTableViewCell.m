//
//  RMBaseTableViewCell.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 24.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseTableViewCell.h"

@implementation RMBaseTableViewCell

+ (CGFloat)height {
    //must override
    return 0;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}
@end
