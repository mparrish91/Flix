//
//  FLMovie.h
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FLMovie : NSObject

@property(strong,readonly,nonatomic) NSString *title;
@property(strong,readonly,nonatomic) NSString *posterPath;
@property(strong,readonly,nonatomic) NSString *backdropPath;
@property(strong,readonly,nonatomic) NSString *overview;
@property(strong,readonly,nonatomic) NSDate *releaseDate;
@property(readonly,nonatomic) NSInteger runtime;
@property(readonly,nonatomic) NSNumber *rating;

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict;


@end
