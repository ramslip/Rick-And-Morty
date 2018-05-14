//
//  RMMainViewController.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseViewController.h"

@class RMFilterView;

@interface RMMainViewController : RMBaseViewController

- (void)updateWithCharacters:(NSArray *)characters;

@end
