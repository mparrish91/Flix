//
//  FLTopRatedTableViewController.m
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLTopRatedTableViewController.h"
#import "FLMoviesTableViewController.h"
#import "FLMovieDetailViewController.h"
#import "FLMovieTableViewCell.h"
#import "FLMovie.h"
#import "UIImageView+AFNetworking.h"
#import "FLNetworkingHelper.h"
#import "FLInfiniteScrollActivityView.h"
#import "MBProgressHUD.h"
#import "FLErrorView.h"


@interface FLTopRatedTableViewController ()

@property(strong,readwrite,nonatomic) NSMutableArray *movies;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *moviesTableView;
@property(nonatomic,strong) UISearchBar *movieSearchBar;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) FLErrorView *errorView;

@property(nonatomic,strong) FLInfiniteScrollActivityView *loadingMoreView;


@end

@implementation FLTopRatedTableViewController


- (void)fetchMovies
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    FLNetworkingHelper *networkingHelper = [[FLNetworkingHelper alloc]init];
    [networkingHelper fetchTopRatedWithCompletionHandler:^(NSArray *objects, NSError *error)
     {
         self.movies = objects;
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         else
         {
             [self hideErrorView:self.errorView];
             
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.moviesTableView reloadData];
             [self.refreshControl endRefreshing];
             self.isMoreDataLoading = false;
             [self.loadingMoreView startAnimating];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         });
         
         
     }
     
     ];
}



- (void)hideErrorView:(FLErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = true;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)showErrorView:(FLErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = false;
        
    } completion:^(BOOL finished) {
    }];
    
}


@end
