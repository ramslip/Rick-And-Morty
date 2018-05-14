//
//  AppDelegate.m
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import "AppDelegate.h"
#import "RMAPIClient+Character.h"
#import "RMMainViewController.h"
#import "RMStoryboardHelper.h"

@interface AppDelegate ()

@property (strong, nonatomic) RMMainViewController *mainVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadCharacters];
    return YES;
}

- (void)loadCharacters {
    self.mainVC = [[RMStoryboardHelper mainStoryboard] instantiateViewControllerWithIdentifier:[RMMainViewController controllerIdentifier]];
    [self loadCharactersForPage:1];
}

- (void)loadCharactersForPage:(NSUInteger)page {
    @weakify(self);
    [[RMAPIClient sharedClient] getAllCharactersOnPage:page WithSuccess:^(NSArray *characters) {
        @strongify(self);
        [self.mainVC updateWithCharacters:characters];
        [self loadCharactersForPage:page + 1];
    } failure:^(NSError *error) {
        @strongify(self);
        self.window.rootViewController = self.mainVC;
        [self.window makeKeyAndVisible];
    }];
}

@end
