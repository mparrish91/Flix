//
//  FLModel-Internal.h
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovie.h"
#import <UIKit/UIKit.h>


@interface FLMovie ()

@property(strong,readwrite,nonatomic) NSString *title;
@property(strong,readwrite,nonatomic) NSString *overview;
@property(strong,readwrite,nonatomic) NSString *posterPath;
@property(strong,readwrite,nonatomic) NSDate *releaseDate;
@property(readwrite,nonatomic) NSInteger runtime;
@property(readwrite,nonatomic) NSString *rating;

@end
