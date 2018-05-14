//
//  RMLocation.h
//  RickAndMorty
//
//  Created by Ekaterina Lapkovskaya on 23.04.2018.
//  Copyright © 2018 Ekaterina Lapkovskaya. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RMLocation : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger Id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *dimension;
@property (strong, nonatomic) NSArray *residentsUrlStrings;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *created;

@end
