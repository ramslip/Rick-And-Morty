//
//  RMSelectSpeciesViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 19.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMSelectSpeciesViewController.h"
#import "RMBaseTableViewCell.h"

static NSString * const RMSelectSpeciesViewControllerAll = @"All";
static NSString * const RMSelectSpeciesViewControllerTextLabelFontName = @"American Typewriter";
static double const RMSelectSpeciesViewControllerTextLabelFontSize = 20;

@interface RMSelectSpeciesViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *speciesArray;
@property (strong, nonatomic) NSString *selectedItem;

@end

@implementation RMSelectSpeciesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[RMBaseTableViewCell self] forCellReuseIdentifier:[RMBaseTableViewCell reuseIdentifier]];
}

- (void)updateWithSelectedItem:(NSString *)selectedItem {
    self.selectedItem = selectedItem;
}

- (void)updateWithSpeciesArray:(NSArray *)species {
    NSMutableArray *speciesMutable = [[NSMutableArray alloc] initWithObjects:RMSelectSpeciesViewControllerAll, nil];
    [speciesMutable addObjectsFromArray:species];
    self.speciesArray = speciesMutable;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RMBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RMBaseTableViewCell reuseIdentifier]];
    cell.textLabel.text = self.speciesArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:RMSelectSpeciesViewControllerTextLabelFontName size:RMSelectSpeciesViewControllerTextLabelFontSize];
    cell.backgroundColor = [cell.textLabel.text isEqualToString:self.selectedItem] ? [UIColor blueColor] : [UIColor whiteColor];
    cell.textLabel.textColor = [cell.textLabel.text isEqualToString:self.selectedItem] ? [UIColor whiteColor] : [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (!self.selectedItem.length && indexPath.row == 0) {
        cell.backgroundColor = [UIColor blueColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.speciesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(speciesDidSelected:)]) {
        RMBaseTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self.delegate speciesDidSelected:cell.textLabel.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
