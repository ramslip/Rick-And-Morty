//
//  RMFilterViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 20.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMFilterViewController.h"
#import "RMSelectSpeciesViewController.h"
#import "MZFormSheetPresentationViewController+RMAdditions.h"
#import "RMStoryboardHelper.h"

static NSString * const RMFilterViewMale = @"Male";
static NSString * const RMFilterViewFemale = @"Female";
static NSString * const RMFilterViewGenderless = @"Genderless";
static NSString * const RMFilterViewUnknown = @"unknown";
static NSString * const RMFilterViewEmpty = @"";
static NSString * const RMFilterViewAll = @"All";
static NSString * const RMFilterViewDead = @"Dead";
static NSString * const RMFilterViewAlive = @"Alive";

static CGFloat const RMFilterViewSelectSpeciesViewControllerWidthOffset = 10.f;
static CGFloat const RMFilterViewSelectSpeciesViewControllerHeight = 400.f;

typedef NS_ENUM (NSUInteger, RMFilterGenderOptions) {
    RMFilterGenderFemale = 0,
    RMFilterGenderMale,
    RMFilterGenderLess,
    RMFilterGenderUnknown,
    RMFilterGenderAll
};

typedef NS_ENUM (NSUInteger, RMFilterStatusOptions) {
    RMFilterStatusDead = 0,
    RMFilterStatusAlive,
    RMFilterStatusUnknown,
    RMFilterStatusAll
};

@interface RMFilterViewController () <RMFilterViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *filteredCharacters;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statsSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (assign, nonatomic) BOOL statusFilterIsOn;
@property (assign, nonatomic) BOOL genderFilterIsOn;
@property (assign, nonatomic) BOOL speciesFilterIsOn;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *species;
@property (strong, nonatomic) UITapGestureRecognizer *viewTapGestureRecognizer;

@end

@implementation RMFilterViewController

+ (NSArray *)genderNames {
    static NSArray *genderNamesArr;
    static dispatch_once_t genderOnceToken;
    dispatch_once(&genderOnceToken, ^{
        NSArray *gendersArr = @[RMFilterViewFemale, RMFilterViewMale, RMFilterViewGenderless, RMFilterViewUnknown, RMFilterViewEmpty];
        genderNamesArr = gendersArr;
    });
    return genderNamesArr;
}

+ (NSArray *)statusNames {
    static NSArray *statusNamesArr;
    static dispatch_once_t statusOnceToken;
    dispatch_once(&statusOnceToken, ^{
        NSArray *statusArr = @[RMFilterViewDead, RMFilterViewAlive, RMFilterViewUnknown, RMFilterViewEmpty];
        statusNamesArr = statusArr;
    });
    return statusNamesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)characters {
    if (!_characters) {
        _characters = [[NSMutableArray alloc] init];
    }
    return _characters;
}

- (BOOL)isFiltering {
    return self.statusFilterIsOn || self.genderFilterIsOn || self.speciesFilterIsOn || self.nameTextField.text.length;
}

- (IBAction)genderSegmentChanged:(UISegmentedControl *)sender {
    self.gender = [RMFilterViewController genderNames][self.genderSegmentControl.selectedSegmentIndex];
    self.genderFilterIsOn = self.genderSegmentControl.selectedSegmentIndex != RMFilterGenderAll;
}

- (IBAction)statusSegmentChanged:(UISegmentedControl *)sender {
    self.status = [RMFilterViewController statusNames][self.statsSegmentControl.selectedSegmentIndex];
    self.statusFilterIsOn = self.statsSegmentControl.selectedSegmentIndex != RMFilterStatusAll;
}

- (NSPredicate *)filterPredicate {
    NSString *predicateString = @"";
    if (self.status.length) {
        predicateString = [NSString stringWithFormat:@"(SELF.status == '%@')", self.status];
    }
    if (self.gender.length) {
        if (predicateString.length) {
            predicateString = [predicateString stringByAppendingString:[NSString stringWithFormat:@" AND (SELF.gender == '%@')", self.gender]];
        } else {
            predicateString = [NSString stringWithFormat:@"(SELF.gender == '%@')", self.gender];
        }
    }
    if (self.species.length) {
        if (predicateString.length) {
            predicateString = [predicateString stringByAppendingString:[NSString stringWithFormat:@" AND (SELF.species == '%@')", self.species]];
        } else {
            predicateString = [NSString stringWithFormat:@"(SELF.species == '%@')", self.species];
        }
    }
    if (self.nameTextField.text.length) {
        if (predicateString.length) {
            predicateString = [predicateString stringByAppendingString:[NSString stringWithFormat:@" AND (SELF.name contains[c] '%@')", self.nameTextField.text]];
        } else {
            predicateString = [NSString stringWithFormat:@"(SELF.name contains[c] '%@')", self.nameTextField.text];
        }
    }
    return [NSPredicate predicateWithFormat:predicateString];
}

- (void)updateWithCharacters:(NSMutableArray *)characters {
    self.characters = characters;
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
    if (self.isFiltering) {
        self.filteredCharacters = [self.characters filteredArrayUsingPredicate:[self filterPredicate]];
    } else {
        self.filteredCharacters = self.characters;
    }
    if ([self.delegate respondsToSelector:@selector(updateWithFilterArray:)]) {
        [self.delegate updateWithFilterArray:self.filteredCharacters];
    }
}

- (IBAction)resetFilterButtonPressed:(UIButton *)sender {
    self.statsSegmentControl.selectedSegmentIndex = RMFilterStatusAll;
    self.genderSegmentControl.selectedSegmentIndex = RMFilterGenderAll;
    self.speciesTextField.text = RMFilterViewEmpty;
    self.nameTextField.text = RMFilterViewEmpty;
    self.species = RMFilterViewEmpty;
    self.gender = RMFilterViewEmpty;
    self.status = RMFilterViewEmpty;
    self.speciesFilterIsOn = NO;
    self.genderFilterIsOn = NO;
    self.statusFilterIsOn = NO;
    self.filteredCharacters = self.characters;
    if ([self.delegate respondsToSelector:@selector(updateWithFilterArray:)]) {
        [self.delegate updateWithFilterArray:self.filteredCharacters];
    }
}

- (void)hideKeyboard {
    [self.nameTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.speciesTextField) {
        RMSelectSpeciesViewController *selectSpeciesViewController = [[RMStoryboardHelper mainStoryboard] instantiateViewControllerWithIdentifier:[RMSelectSpeciesViewController controllerIdentifier]];
        NSArray *uniqueSpecies = [self.characters valueForKeyPath:@"@distinctUnionOfObjects.species"];
        uniqueSpecies = [uniqueSpecies sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        selectSpeciesViewController.delegate = self;
        [selectSpeciesViewController updateWithSpeciesArray:uniqueSpecies];
        [selectSpeciesViewController updateWithSelectedItem:self.species];
        MZFormSheetPresentationViewController *formSheetController = [MZFormSheetPresentationViewController formSheetPresentationAgreementWithSize:CGSizeMake(self.view.frame.size.width - RMFilterViewSelectSpeciesViewControllerWidthOffset, RMFilterViewSelectSpeciesViewControllerHeight) contentViewController:selectSpeciesViewController];
         [self presentViewController:formSheetController animated:YES completion:nil];
        return NO;
    } else {
        self.viewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [self.view addGestureRecognizer:self.viewTapGestureRecognizer];
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.nameTextField resignFirstResponder];
        [self.view removeGestureRecognizer:self.viewTapGestureRecognizer];
        return YES;
    }
    return NO;
}

#pragma mark - RMFilterViewDelegate

- (void)speciesDidSelected:(NSString *)selectedSpecies {
    self.species = selectedSpecies;
    self.speciesFilterIsOn = YES;
    if ([self.species isEqualToString:RMFilterViewAll]) {
        self.species = RMFilterViewEmpty;
        self.speciesFilterIsOn = NO;
    }
    self.speciesTextField.text = self.species;
}

@end
