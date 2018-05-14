//
//  RMLocationTableViewCell.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMLocationTableViewCell.h"
#import "RMLocation.h"

static CGFloat const RMLocationTableViewCellHeight = 150;

@interface RMLocationTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dimensionLabel;

@end

@implementation RMLocationTableViewCell

- (void)updateWithLocation:(RMLocation *)location {
    self.nameLabel.text = location.name;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.text = location.type;
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.dimensionLabel.text = location.dimension;
}

+ (CGFloat)height {
    return RMLocationTableViewCellHeight;
}

@end
