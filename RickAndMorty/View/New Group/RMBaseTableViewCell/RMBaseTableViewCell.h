//
//  RMBaseTableViewCell.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 24.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMBaseTableViewCell : UITableViewCell

+ (CGFloat)height;
+ (NSString *)reuseIdentifier;

@end
