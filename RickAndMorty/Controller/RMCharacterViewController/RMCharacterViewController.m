//
//  RMCharacterViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMCharacterViewController.h"
#import "RMCharacter.h"

static CGFloat const RMCharacterViewControllerImageFrame = 15;
static CGFloat const RMCharacterViewControllerLabelsBlackViewFrame = 30;

@interface RMCharacterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idWhenCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastLocationLabel;
@property (weak, nonatomic) IBOutlet UIView *labelsBlackView;

@property (strong, nonatomic) RMCharacter *charachter;

@end

@implementation RMCharacterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.charachter.imageUrlString]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.imageView setImage:image];
        });
    });
    self.nameLabel.text = self.charachter.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:self.charachter.createdDataSrting];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units =  NSCalendarUnitMonth;
    NSDateComponents *components = [gregorian components:units fromDate:date toDate:[NSDate date] options:0];
    NSInteger months = [components month];

    self.idWhenCreatedLabel.text = [NSString stringWithFormat:[RMStringsHelper stringForKey:@"controller.character.created"], (unsigned long)self.charachter.Id, (long)months];
    self.statusLabel.text = self.charachter.status;
    self.speciesLabel.text = self.charachter.species;
    self.originLabel.text = self.charachter.originName;
    self.lastLocationLabel.text = self.charachter.locationName;
    self.originLabel.adjustsFontSizeToFitWidth = YES;
    self.lastLocationLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.idWhenCreatedLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)updateWithCharacter:(RMCharacter *)character {
    self.charachter = character;
}

- (void)zoomingImageIn {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.frame = [self changeViewFrame:self.imageView originMinusOffset:RMCharacterViewControllerImageFrame sizePlusOffset:RMCharacterViewControllerLabelsBlackViewFrame];
        self.labelsBlackView.frame = [self changeViewFrame:self.labelsBlackView originMinusOffset:RMCharacterViewControllerImageFrame sizePlusOffset:RMCharacterViewControllerLabelsBlackViewFrame];
    } completion:^(BOOL finished) {
    }];
}

- (void)zoomingImageOut {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.frame = [self changeViewFrame:self.imageView originMinusOffset:-RMCharacterViewControllerImageFrame sizePlusOffset:-RMCharacterViewControllerLabelsBlackViewFrame];
        self.labelsBlackView.frame = [self changeViewFrame:self.labelsBlackView originMinusOffset:-RMCharacterViewControllerImageFrame sizePlusOffset:-RMCharacterViewControllerLabelsBlackViewFrame];
    } completion:^(BOOL finished) {
    }];
}

- (CGRect)changeViewFrame:(UIView *)view
      originMinusOffset:(CGFloat)originMinusOffset
        sizePlusOffset:(CGFloat) sizePlusOffset {
    CGRect newRect = view.frame;
    newRect.origin.x -= originMinusOffset;
    newRect.origin.y -= originMinusOffset;
    newRect.size.height += sizePlusOffset;
    newRect.size.width += sizePlusOffset;
    return newRect;
}

@end
