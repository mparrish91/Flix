//
//  FLErrorView.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLErrorView.h"

@interface FLErrorView ()
@property(strong,readwrite,nonatomic) UILabel *titleLabel;
@property(strong,readwrite,nonatomic) UIImageView *errorImageView;


@end


@implementation FLErrorView


- (instancetype)initWithFrame:(CGRect)frame
{
    self.errorImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    
    
    if (!(self = [super initWithFrame:frame]))
        return nil;
    

    [self addSubview:self.errorImageView];
//    [self addSubview:self.titleLabel];
    
    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.layoutMarginsGuide;

    
    self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3f];
    
    
    self.errorImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.errorImageView.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
//    [self.errorImageView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    [self.errorImageView.widthAnchor constraintEqualToConstant:21].active = YES;
    [self.errorImageView.heightAnchor constraintEqualToConstant:21].active = YES;


    self.errorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.errorImageView.image = [UIImage imageNamed:@"errorViewIcon"];
//    
//    
//    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
//    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.errorImageView.trailingAnchor constant:-10].active = YES;
//    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
//    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
//    self.titleLabel.textAlignment = NSTextAlignmentLeft;
//    self.titleLabel.text = @"Network Error";
//    self.titleLabel.textColor = [UIColor whiteColor];

}


@end
