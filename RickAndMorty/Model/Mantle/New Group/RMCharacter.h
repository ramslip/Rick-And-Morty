//
//  RMCharacter.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 12.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RMCharacter : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger Id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *species;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *originName;
@property (strong, nonatomic) NSString *originUrlString;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSString *locationUrlString;
@property (strong, nonatomic) NSString *imageUrlString;
@property (strong, nonatomic) NSArray *episodesUrlStringsArray;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *createdDataSrting;

@end
