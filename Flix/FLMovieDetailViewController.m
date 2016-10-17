//
//  FLMovieDetailViewController.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FLMovieDetailView.h"
#import "FLMovie.h"


@interface FLMovieDetailViewController ()

@property(strong,nonatomic) UIImageView *posterImageView;
@property(strong,readwrite,nonatomic) NSString *url;
@property(strong,nonatomic) FLMovieDetailView *detailView;

@property(strong,readwrite,nonatomic) FLMovie *movie;


@end

@implementation FLMovieDetailViewController


#pragma mark - Initialize

- (instancetype)initWithMovie:(FLMovie *)movie
{
    self.posterImageView = [[UIImageView alloc]init];
    self.detailView = [[FLMovieDetailView alloc]initWithMovie:movie];
    
    
    if (!(self = [super init]))
        return nil;
    
    self.movie = movie;
    
    
    return  self;
    
}


- (instancetype)initWithURL:(NSString *)url
{
    self.posterImageView = [[UIImageView alloc]init];
    self.posterImageView = [[UIImageView alloc]init];

    
    if (!(self = [super init]))
        return nil;
    
    self.url = url;
    
    
    return  self;
    
}

#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setConstraints];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:[self.movie posterPath]] placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    
}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // add subviews
    self.view = view;
    view.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:self.posterImageView];
    [view addSubview:self.detailView];

}

- (void)imageTapped:(UITapGestureRecognizer *)sender
{
    UIView *theSuperview = self.view; // whatever view contains your image views
    CGPoint touchPointInSuperview = [sender locationInView:theSuperview];
    UIView *touchedView = [theSuperview hitTest:touchPointInSuperview withEvent:nil];
   
}


#pragma mark - AutoLayout

-(void)setConstraints
{

    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    self.posterImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.posterImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.posterImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.posterImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.posterImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    self.posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.detailView.translatesAutoresizingMaskIntoConstraints = false;
    [self.detailView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.detailView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.detailView.heightAnchor constraintEqualToConstant: 220].active = YES;
    [self.detailView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;

    self.detailView.contentMode = UIViewContentModeScaleAspectFit;
    
}


@end
