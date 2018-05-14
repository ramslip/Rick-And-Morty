//
//  MZFormSheetPresentationViewController+RMAdditions.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 19.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "MZFormSheetPresentationViewController+RMAdditions.h"

static CGFloat const MZFormSheetPresentationViewControllerShadowRadius = 10;
static CGFloat const MZFormSheetPresentationViewControllerContentViewCornerRadius = 10;
static CGFloat const MZFormSheetPresentationViewControllerBackgroundAlpha = .4;

@implementation MZFormSheetPresentationViewController (RMAdditions)

+ (MZFormSheetPresentationViewController *)formSheetPresentationViewControllerWithSize:(CGSize)size contentViewController:(UIViewController *)contentViewController {
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:contentViewController];
    formSheetController.presentationController.contentViewSize = size;
    formSheetController.presentationController.shouldCenterVertically = YES;
    formSheetController.presentationController.movementActionWhenKeyboardAppears = MZFormSheetActionWhenKeyboardAppearsMoveToTop;
    formSheetController.shadowRadius = MZFormSheetPresentationViewControllerShadowRadius;
    
    return formSheetController;
}

+ (MZFormSheetPresentationViewController *)formSheetPresentationAgreementWithSize:(CGSize)size contentViewController:(UIViewController *)contentViewController {
    MZFormSheetPresentationViewController *formSheetController = [self.class formSheetPresentationViewControllerWithSize:size contentViewController:contentViewController];
    formSheetController.contentViewCornerRadius = MZFormSheetPresentationViewControllerContentViewCornerRadius;
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.shouldApplyBackgroundBlurEffect = NO;
    formSheetController.presentationController.backgroundColor = [UIColor colorWithWhite:.0 alpha:MZFormSheetPresentationViewControllerBackgroundAlpha];
    return formSheetController;
}

@end
