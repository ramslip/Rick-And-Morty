//
//  RMCharacterViewController.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMBaseViewController.h"

@class RMCharacter;

@interface RMCharacterViewController : RMBaseViewController

- (void)updateWithCharacter:(RMCharacter *)character;
- (void)zoomingImageIn;
- (void)zoomingImageOut;

@end

