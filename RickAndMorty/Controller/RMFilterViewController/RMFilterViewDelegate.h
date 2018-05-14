//
//  RMFilterViewDelegate.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 18.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MZFormSheetPresentationViewController;

@protocol RMFilterViewDelegate <NSObject>

@optional

- (void)updateWithFilterArray:(NSArray *)filteredArray;
- (void)speciesDidSelected:(NSString *)selectedSpecies;

@end
