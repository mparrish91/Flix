//
//  FLMovieDetailViewController.h
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLMovie.h"


@interface FLMovieDetailViewController : UIViewController

- (instancetype)initWithURL:(NSString *)url;
- (instancetype)initWithMovie:(FLMovie *)movie;


@end
