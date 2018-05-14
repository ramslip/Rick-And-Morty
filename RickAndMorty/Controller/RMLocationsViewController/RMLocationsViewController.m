//
//  RMLocationsTableViewController.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "RMLocationsViewController.h"
#import "RMAPIClient+Location.h"
#import "RMLocationTableViewCell.h"

@interface RMLocationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *locations;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RMLocationsViewController

- (NSMutableArray *)locations {
    if (!_locations) {
        _locations = [[NSMutableArray alloc] init];
    }
    return _locations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:[RMLocationTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[RMLocationTableViewCell reuseIdentifier]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
    [self loadLocationsForPage:1];
}

- (void)leftSwipe {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadLocationsForPage:(NSUInteger)page {
    @weakify(self);
    [[RMAPIClient sharedClient] getLocationsOnPage:page WithSuccess:^(NSArray *locations) {
        @strongify(self);
        [self updateWithLocations:locations];
        [self loadLocationsForPage:page + 1];
    } failure:^(NSError *error) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)updateWithLocations:(NSArray *)locations {
    [self.locations addObjectsFromArray:locations];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RMLocationTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell updateWithLocation:self.locations[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RMLocationTableViewCell height];
}

@end
