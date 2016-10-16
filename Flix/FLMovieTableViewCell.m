//
//  FLMovieTableViewCell.m
//  Flix
//
//  Created by parry on 10/12/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface FLMovieTableViewCell ()

@end


@implementation FLMovieTableViewCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self.photoImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    self.overviewLabel = [[UILabel alloc]init];
    
    
    
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [[self contentView]addSubview:self.photoImageView];
    [[self contentView]addSubview:self.titleLabel];
    [[self contentView]addSubview:self.overviewLabel];
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.photoImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToConstant:50];
    [self.photoImageView.heightAnchor constraintEqualToConstant:50];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:10].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
//    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.overviewLabel.topAnchor constant:5].active = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14];
    
    
    self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.overviewLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:10].active = YES;
    [self.overviewLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:10].active = YES;

    [self.overviewLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:15].active = YES;
    self.overviewLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.overviewLabel.textColor = [UIColor grayColor];
    self.overviewLabel.numberOfLines = 0;
    self.overviewLabel.lineBreakMode = NSLineBreakByWordWrapping;


    
}


@end

