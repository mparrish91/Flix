//
//  FLMovieDetailView.m
//  Flix
//
//  Created by parry on 10/16/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieDetailView.h"
#import "FLMovie.h"

@interface FLMovieDetailView ()

@property(strong,readwrite,nonatomic) FLMovie *movie;

@end


@implementation FLMovieDetailView


- (instancetype)initWithMovie:(FLMovie *)movie
{
    self.titleLabel = [[UILabel alloc]init];
    self.releaseDateLabel = [[UILabel alloc]init];
    self.ratingLabel = [[UILabel alloc]init];
    self.overviewLabel = [[UILabel alloc]init];
    self.movie = movie;
    
    if (!(self = [super init]))
        return nil;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.releaseDateLabel];
//    [self addSubview:self.ratingLabel];
    [self addSubview:self.overviewLabel];

    return self;
}



-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.layoutMarginsGuide;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = [self.movie title];
    self.titleLabel.textColor = [UIColor whiteColor];

    
    self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.releaseDateLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.releaseDateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5].active = YES;
    self.releaseDateLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.releaseDateLabel.textAlignment = NSTextAlignmentLeft;
    self.releaseDateLabel.text = [self convertDateToString:[self.movie releaseDate]];
    self.releaseDateLabel.textColor = [UIColor whiteColor];


    
//    self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false;
//    [self.ratingLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
//    [self.ratingLabel.topAnchor constraintEqualToAnchor:self.releaseDateLabel.bottomAnchor constant:5].active = YES;
//    self.ratingLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
//    self.ratingLabel.textAlignment = NSTextAlignmentLeft;
//    self.ratingLabel.text = [self convertToPercent:[self.movie rating]];
//    self.ratingLabel.textColor = [UIColor whiteColor];


    
    self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.overviewLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.overviewLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.overviewLabel.topAnchor constraintEqualToAnchor:self.releaseDateLabel.bottomAnchor constant:5].active = YES;
    [self.overviewLabel.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    self.overviewLabel.text = [self.movie overview];



    self.overviewLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.overviewLabel.textAlignment = NSTextAlignmentLeft;
    [self.overviewLabel sizeToFit];
    self.overviewLabel.textColor = [UIColor whiteColor];
    self.overviewLabel.numberOfLines = 0;
    self.overviewLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.text = [self.movie title];



}

- (NSString *)convertDateToString: (NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"mm.dd.yyyy"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    
    return dateStr;
}

- (NSString *)convertToPercent: (NSString *)str
{
    NSString * newStr = [NSString stringWithFormat:@"%.1f%%", [str floatValue]*100];
    
    return newStr;
}

@end
