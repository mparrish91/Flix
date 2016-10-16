//
//  FLMovieTableViewCell.h
//  Flix
//
//  Created by parry on 10/12/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLMovieTableViewCell : UITableViewCell


@property(strong,readwrite,nonatomic) UILabel *titleLabel;
@property(strong,readwrite,nonatomic) UIImageView *photoImageView;
@property(strong,readwrite,nonatomic) UILabel *overviewLabel;

@end
