//
//  RMSelectSpeciesViewController.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 19.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseViewController.h"
#import "RMFilterViewDelegate.h"

@interface RMSelectSpeciesViewController : RMBaseViewController

@property (weak, nonatomic) id <RMFilterViewDelegate> delegate;

- (void)updateWithSelectedItem:(NSString *)selectedItem;
- (void)updateWithSpeciesArray:(NSArray *)species;

@end
