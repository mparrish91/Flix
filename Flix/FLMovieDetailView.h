//
//  FLMovieDetailView.h
//  Flix
//
//  Created by parry on 10/16/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLMovieDetailView : UIView

@property(strong,readwrite,nonatomic) UILabel *titleLabel;
@property(strong,readwrite,nonatomic) UILabel *overviewLabel;

@property(strong,readwrite,nonatomic) UILabel *releaseDateLabel;
@property(strong,readwrite,nonatomic) UILabel *ratingLabel;



@end
