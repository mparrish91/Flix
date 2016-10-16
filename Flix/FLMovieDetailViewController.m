//
//  FLMovieDetailViewController.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"


@interface FLMovieDetailViewController ()

@property(strong,nonatomic) UIImageView *posterImageView;
@property(strong,readwrite,nonatomic) NSString *url;


@end

@implementation FLMovieDetailViewController


#pragma mark - Initialize


- (instancetype)initWithURL:(NSString *)url
{
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
    [self.posterImageView setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
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
    
    UIView *view = self.view;
    
    self.posterImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.posterImageView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.posterImageView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.posterImageView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.posterImageView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    self.posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}


@end
