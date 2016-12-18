//
//  FLMovieCollectionViewCell.m
//  Flix
//
//  Created by parry on 12/18/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieCollectionViewCell.h"

@implementation FLMovieCollectionViewCell
#pragma mark - Initialize

-(instancetype)initWithFrame:(CGRect)frame
{
    self.photoImageView = [[UIImageView alloc]init];
    
    
    
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [[self contentView]addSubview:self.photoImageView];
    
    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.photoImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [self.photoImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.photoImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
}


@end
