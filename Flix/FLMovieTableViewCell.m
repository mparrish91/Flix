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
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;

    [self.photoImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.photoImageView.bottomAnchor constraintLessThanOrEqualToAnchor:margins.bottomAnchor constant:0].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoImageView.layer.cornerRadius = 17;
    self.photoImageView.layer.masksToBounds = YES;

    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.titleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:margins.trailingAnchor].active = YES;

    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.overviewLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.overviewLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;

    [self.overviewLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5].active = YES;
    [self.overviewLabel.bottomAnchor constraintLessThanOrEqualToAnchor:margins.bottomAnchor constant:0].active = YES;
    [self.overviewLabel sizeToFit];

    self.overviewLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.overviewLabel.textColor = [UIColor grayColor];
    self.overviewLabel.numberOfLines = 0;
    self.overviewLabel.lineBreakMode = NSLineBreakByTruncatingTail;


    
}



@end

