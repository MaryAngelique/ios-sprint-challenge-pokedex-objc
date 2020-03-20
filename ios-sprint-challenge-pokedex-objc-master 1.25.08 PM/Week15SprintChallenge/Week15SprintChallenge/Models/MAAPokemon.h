//
//  MAAPokemon.h
//  Week15SprintChallenge
//
//  Created by Angelique Abacajan on 3/20/20.
//  Copyright © 2020 Angelique Abacajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAAPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic, nullable) NSURL *infoURL;
@property (nonatomic) int idenitifier;
@property (nonatomic, copy, nullable) NSString *abilities;
@property (nonatomic, copy, nullable) NSURL *sprite;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                             infoURL:(nullable NSURL *)infoURL
                          identifier:(int)identifier
                           abilities:(nullable NSString *)abilities
                              sprite:(nullable NSURL *)sprite;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
