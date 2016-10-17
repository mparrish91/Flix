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
    
    CGRect frame = CGRectMake(0, 350, 320, 100);

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
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = [self.movie title];
    
    self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.releaseDateLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.releaseDateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor].active = YES;
    self.releaseDateLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.releaseDateLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = [self convertDateToString:[self.movie releaseDate]];

    
    self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.ratingLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.ratingLabel.topAnchor constraintEqualToAnchor:self.releaseDateLabel.topAnchor].active = YES;
    self.ratingLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.ratingLabel.textAlignment = NSTextAlignmentLeft;
//    NSString *finalNumber = [NSString stringWithFormat:@"%.1f%%", [NSNumber self.ratingLabel.text]*100];
//    self.ratingLabel.textAlignment = finalNumber;
    self.titleLabel.text = [self convertToPercent:[self.movie rating]];

    
    self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.overviewLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.overviewLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.overviewLabel.topAnchor constraintEqualToAnchor:self.ratingLabel.topAnchor].active = YES;
    [self.overviewLabel.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    self.titleLabel.text = [self.movie overview];


    self.overviewLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.overviewLabel.textAlignment = NSTextAlignmentLeft;
    [self.overviewLabel sizeToFit];
    self.overviewLabel.textColor = [UIColor grayColor];
    self.overviewLabel.numberOfLines = 0;
    self.overviewLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.text = [self.movie title];



}

- (NSString *)convertDateToString: (NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.YY"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    
    return dateStr;
}

- (NSString *)convertToPercent: (NSString *)str
{
    NSString * newStr = [NSString stringWithFormat:@"%.1f%%", [str floatValue]*100];
    
    return newStr;
}

@end
