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
#import "UIImageView+AFNetworkingFadeInAdditions.h"


@interface FLMovieDetailViewController ()

@property(strong,nonatomic) UIImageView *posterImageView;
@property(strong,readwrite,nonatomic) NSString *url;
@property(strong,nonatomic) FLMovieDetailView *detailView;

@property(strong,readwrite,nonatomic) FLMovie *movie;

@property (nonatomic,assign) BOOL isViewHidden;
@property(strong,readwrite,nonatomic) NSLayoutConstraint *constr;


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
    
    [self.posterImageView setImageWithURL:[NSURL URLWithString:[self.movie posterPath]]  placeholderImage:[UIImage imageNamed:@"placeholder-background"] fadeInWithDuration:0.2f];


    //load one image after the other. just have to request low res from server
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.movie posterPath]]];
//    [request setHTTPShouldHandleCookies:NO];
//    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
//    
//    [self.posterImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"placeholder-background"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        [UIView transitionWithView:weakSelf duration:0.2f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            //[weakSelf setImage:image];
//        } completion:
//nil
//         
//         ];
//    } failure:nil];

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.isViewHidden = NO;


    
    
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
    if (self.isViewHidden)
    {
        [self showViewAnimated];
    }
    else
    {
        [self hideViewAnimated];

    }
   
}

- (void)hideViewAnimated
{
    UILayoutGuide *margins = self.view.layoutMarginsGuide;

    [UIView animateWithDuration:1.0 animations:^{
        self.constr.active = NO;
        self.constr = [self.detailView.topAnchor constraintEqualToAnchor:margins.bottomAnchor];
        self.constr.active = YES;

        [self.view layoutIfNeeded];

        self.isViewHidden = YES;

    }];
    
    
}

- (void)showViewAnimated
{
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.constr.active = NO;
        self.constr = [self.detailView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor];
        self.constr.active = YES;


        
        [self.view layoutIfNeeded];
        self.isViewHidden = NO;

    }];
    
}






#pragma mark - AutoLayout

-(void)setConstraints
{

    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    self.posterImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.posterImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.posterImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.posterImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.posterImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:15].active = YES;
    self.posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.detailView.translatesAutoresizingMaskIntoConstraints = false;
    [self.detailView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.detailView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.detailView.heightAnchor constraintEqualToConstant: 220].active = YES;
//    [self.detailView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;

    self.constr = [self.detailView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor];
    self.constr.active = YES;

    
    self.detailView.contentMode = UIViewContentModeScaleAspectFit;
    
}




@end
