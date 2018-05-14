//
//  MZFormSheetPresentationViewController+RMAdditions.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 19.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "MZFormSheetPresentationViewController.h"

@interface MZFormSheetPresentationViewController (RMAdditions)

+ (MZFormSheetPresentationViewController *)formSheetPresentationAgreementWithSize:(CGSize)size contentViewController:(UIViewController *)contentViewController;

@end
