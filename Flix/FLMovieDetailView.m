//
//  FLMovieDetailView.m
//  Flix
//
//  Created by parry on 10/16/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieDetailView.h"

@interface FLMovieDetailView ()


@end


@implementation FLMovieDetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self.titleLabel = [[UILabel alloc]init];
    self.releaseDateLabel = [[UILabel alloc]init];
    self.ratingLabel = [[UILabel alloc]init];
    self.overviewLabel = [[UILabel alloc]init];
    
    
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.releaseDateLabel];
    [self addSubview:self.ratingLabel];
    [self addSubview:self.overviewLabel];

    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.layoutMarginsGuide;
    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.errorImageView.trailingAnchor constant:-10].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.overviewLabel.leadingAnchor constraintEqualToAnchor:self.errorImageView.trailingAnchor constant:-10].active = YES;
    [self.overviewLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    //    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.overviewLabel.topAnchor constant:5].active = YES;
    self.overviewLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.overviewLabel.textAlignment = NSTextAlignmentLeft;
    
    self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.ratingLabel.leadingAnchor constraintEqualToAnchor:self.errorImageView.trailingAnchor constant:-10].active = YES;
    [self.ratingLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.ratingLabel.bottomAnchor constraintEqualToAnchor:self.overviewLabel.topAnchor constant:5].active = YES;
    self.ratingLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.ratingLabel.textAlignment = NSTextAlignmentLeft;
    
    self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.releaseDateLabel.leadingAnchor constraintEqualToAnchor:self.errorImageView.trailingAnchor constant:-10].active = YES;
    [self.releaseDateLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.releaseDateLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.releaseDateLabel.textAlignment = NSTextAlignmentLeft;
    
    

    
    
}

@end
