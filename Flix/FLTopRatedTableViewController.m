//
//  FLTopRatedTableViewController.m
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLTopRatedTableViewController.h"
#import "FLMoviesTableViewController.m"

//#import "FLMoviesTableViewController.h"
//#import "FLMovieDetailViewController.h"
//#import "FLMovieTableViewCell.h"
//#import "FLMovie.h"
//#import "UIImageView+AFNetworking.h"
//#import "FLNetworkingHelper.h"
//#import "FLInfiniteScrollActivityView.h"
//#import "MBProgressHUD.h"
//#import "FLErrorView.h"


@interface FLTopRatedTableViewController ()

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


@end
