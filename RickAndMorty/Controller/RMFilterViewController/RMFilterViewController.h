//
//  RMFilterViewController.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 20.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseViewController.h"
#import "RMFilterViewDelegate.h"

@interface RMFilterViewController : RMBaseViewController

@property (assign, nonatomic) BOOL isFiltering;
@property (strong, nonatomic) NSMutableArray *characters;
@property (weak, nonatomic) id<RMFilterViewDelegate> delegate;

- (void)updateWithCharacters:(NSArray *)characters;

@end
