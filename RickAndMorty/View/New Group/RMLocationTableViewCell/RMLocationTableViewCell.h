//
//  RMLocationTableViewCell.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseTableViewCell.h"

@class RMLocation;

@interface RMLocationTableViewCell : RMBaseTableViewCell

- (void)updateWithLocation:(RMLocation *)location;

@end
