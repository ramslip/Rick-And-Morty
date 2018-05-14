//
//  RMMainViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMMainViewController.h"
#import <CRPageViewController/CRPageViewController.h>
#import "RMCharacterViewController.h"
#import "RMFilterViewController.h"
#import "RMFilterViewDelegate.h"
#import "MZFormSheetPresentationViewController+RMAdditions.h"
#import "RMLocationsViewController.h"
#import "RMStoryboardHelper.h"
#import <CBZSplashView.h>

static CGFloat const RMMainViewControllerSizeBetweenCards = 10.f;
static CGFloat const RMMainViewControllerCardsAnimationSpeed = 0.4;
static CGFloat const RMFilterViewControllerWidthOffset = 10.f;
static CGFloat const RMFilterViewControllerHeight = 410.f;
static CGSize const RMMainViewControllerCardSize = {250.f, 500.f};

@interface RMMainViewController () <CRPageViewControllerDataSource, RMFilterViewDelegate>

@property (strong, nonatomic) CRPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray <RMCharacterViewController *> *sourse;
@property (assign, nonatomic) NSInteger viewControllersNumber;
@property (strong, nonatomic) NSMutableArray *dataSourse;
@property (strong, nonatomic) NSMutableArray *originalCharcters;
@property (assign, nonatomic) BOOL loadingCompleted;
@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (strong, nonatomic) UITapGestureRecognizer *blurViewTapGestureRecognizer;
@property (strong, nonatomic) RMFilterViewController *filterViewController;

@end

@implementation RMMainViewController

- (NSMutableArray *)dataSourse {
    if (!_dataSourse) {
        _dataSourse = [[NSMutableArray alloc] init];
    }
    return _dataSourse;
}

- (NSMutableArray *)originalCharcters {
    if (!_originalCharcters) {
        _originalCharcters = [[NSMutableArray alloc] init];
    }
    return _originalCharcters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterViewController = [[RMStoryboardHelper mainStoryboard] instantiateViewControllerWithIdentifier:[RMFilterViewController controllerIdentifier]];
    self.filterViewController.delegate = self;
    
    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showOptions)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGestureRecognizer];
    self.blurView.alpha = 0;
}

- (void)showOptions {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:[RMStringsHelper stringForKey:@"title.cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[RMStringsHelper stringForKey:@"title.locations"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showLocations];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[RMStringsHelper stringForKey:@"title.filter"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showFilter];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showLocations {
    RMLocationsViewController *locationsViewController = [[RMStoryboardHelper mainStoryboard] instantiateViewControllerWithIdentifier:[RMLocationsViewController controllerIdentifier]];
    [self presentViewController:locationsViewController animated:YES completion:nil];
}

- (void)showFilter {
    [self.filterViewController updateWithCharacters:self.originalCharcters];
    MZFormSheetPresentationViewController *formSheetController = [MZFormSheetPresentationViewController formSheetPresentationAgreementWithSize:CGSizeMake(self.view.frame.size.width - RMFilterViewControllerWidthOffset, RMFilterViewControllerHeight) contentViewController:self.filterViewController];
    [self presentViewController:formSheetController animated:YES completion:nil];
}

- (void)updateWithCharacters:(NSArray *)characters {
    [self.dataSourse addObjectsFromArray:characters];
    self.loadingCompleted = YES;
    [self.originalCharcters addObjectsFromArray:characters];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (!self.loadingCompleted) {
        return;
    }
    [self reloadPageViewController];
}

- (void)reloadPageViewController {
    [self.pageViewController.view removeFromSuperview];
    self.pageViewController = [CRPageViewController new];
    self.sourse = [NSMutableArray new];
    self.viewControllersNumber = 3;
    for (int i = 0; i < self.viewControllersNumber; i++) {
        [self.sourse addObject:[self createViewControllerWithNumber:i]];
    }
    self.pageViewController.countPageInController = self.viewControllersNumber;
    self.pageViewController.childVCSize = RMMainViewControllerCardSize;
    self.pageViewController.sizeBetweenVC = RMMainViewControllerSizeBetweenCards;
    self.pageViewController.OffsetOfHeightCentralVC = 0;
    self.pageViewController.animationSpeed = RMMainViewControllerCardsAnimationSpeed;
    self.pageViewController.animation = UIViewAnimationCurveEaseInOut;
    self.pageViewController.viewControllers = [NSMutableArray arrayWithArray:self.sourse];
    self.pageViewController.dataSource = self;
    for (int i = (int)self.viewControllersNumber; i < self.dataSourse.count; i++) {
        [self.sourse addObject:[self createViewControllerWithNumber:i]];
    }
    [self.view addSubview:self.pageViewController.view];
}

- (RMCharacterViewController*)createViewControllerWithNumber:(NSUInteger)number {
    if (number >= self.dataSourse.count) {
        return [[RMCharacterViewController alloc] init];
    }
    RMCharacterViewController *childVC = [[RMStoryboardHelper mainStoryboard] instantiateViewControllerWithIdentifier:[RMCharacterViewController controllerIdentifier]];
    [childVC updateWithCharacter:self.dataSourse[number]];
    return childVC;
}

#pragma mark - CRPageViewControllerDelegate

- (void)unfocusedViewController:(RMCharacterViewController *)viewController {
    [viewController zoomingImageOut];
}

- (void)focusedViewController:(RMCharacterViewController *)viewController {
    [viewController zoomingImageIn];
}

- (RMCharacterViewController *)pageViewController:(CRPageViewController *)pageViewController viewControllerAfterViewController:(RMCharacterViewController *)viewController {
    NSInteger numberViewControllerInSourse = [self.sourse indexOfObject:viewController] + 1;
    if (numberViewControllerInSourse >= self.sourse.count) {
        numberViewControllerInSourse = 0;
    }
    return self.sourse[numberViewControllerInSourse];
}

- (RMCharacterViewController *)pageViewController:(CRPageViewController *)pageViewController viewControllerBeforeViewController:(RMCharacterViewController *)viewController {
    NSInteger numberViewControllerInSourse = [self.sourse indexOfObject:viewController] - 1;
    if (numberViewControllerInSourse < 0) {
        numberViewControllerInSourse = self.sourse.count - 1;
    }
    return self.sourse[numberViewControllerInSourse];
}

#pragma mark - RMFilterViewDelegate

- (void)updateWithFilterArray:(NSArray *)filteredArray {
    if (self.filterViewController.isFiltering) {
        self.dataSourse = [[NSMutableArray alloc] initWithArray:filteredArray];
    } else {
        self.dataSourse = self.filterViewController.characters;
    }
    [self.filterViewController dismissViewControllerAnimated:YES completion:nil];
    [self reloadPageViewController];
}

@end
