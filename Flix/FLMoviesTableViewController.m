//
//  FLMoviesTableViewController.m
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMoviesTableViewController.h"
#import "FLMovieDetailViewController.h"
#import "FLMovieTableViewCell.h"
#import "FLMovie.h"
#import "UIImageView+AFNetworking.h"
#import "FLNetworkingHelper.h"
#import "FLInfiniteScrollActivityView.h"
#import "MBProgressHUD.h"
#import "FLErrorView.h"



@interface FLMoviesTableViewController ()

@property(strong,readwrite,nonatomic) NSMutableArray *movies;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *moviesTableView;
@property(nonatomic,strong) UISearchBar *movieSearchBar;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) FLErrorView *errorView;
@property(nonatomic,strong) FLNetworkingHelper *networkingHelper;




@property(nonatomic,strong) FLInfiniteScrollActivityView *loadingMoreView;

@end

@implementation FLMoviesTableViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.moviesTableView = [[UITableView alloc]init];
//    self.movieSearchBar = [[UISearchBar alloc]init];
    self.errorView = [[FLErrorView alloc]init];
    self.movies = [[NSMutableArray alloc] init];
    self.networkingHelper = [[FLNetworkingHelper alloc]init];

    
    self = [super init];
    if(self) {
    }
    return self;
}



- (instancetype)initWithMovies:(NSArray *)movieArray
{
    self = [super init];
    if(self) {
        self.movies = movieArray;
    }
    return self;
}

#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Flix";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    self.movieSearchBar.frame = CGRectMake(0, 0, 320, 50);
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.moviesTableView registerClass:[FLMovieTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.moviesTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UIEdgeInsets insets = self.moviesTableView.contentInset;
    insets.bottom += FLInfiniteScrollActivityView.defaultHeight + self.tabBarController.tabBar.frame.size.height;
    self.moviesTableView.contentInset = insets;

    
    [self setConstraints];
    [self fetchMovies];

}


- (void)fetchMovies
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self.networkingHelper fetchNowPlayingWithCompletionHandler:^(NSArray *objects, NSError *error)
     {

         if (error)
         {
             [self showErrorView:self.errorView];
         }
         else
         {
             [self hideErrorView:self.errorView];

         }
         [self.movies addObjectsFromArray:objects];

         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             [self.loadingMoreView stopAnimating];

             [self.refreshControl endRefreshing];
             [self.moviesTableView reloadData];
             [MBProgressHUD hideHUDForView:self.view animated:YES];

             });
     }
     
     ];
}



#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    FLMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[FLMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    FLMovie *movie = [self.movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = [movie title];
//    cell.overviewLabel.text = [self convertDateToString:movie.releaseDate];
    cell.overviewLabel.text = [movie overview];
    NSString *photoImageURL = [movie posterPath];


    [cell.photoImageView setImageWithURL:[NSURL URLWithString:photoImageURL] placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    FLMovie *movie = [self.movies objectAtIndex:indexPath.row];
    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
//    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
    [self.navigationController pushViewController:detailVC animated:true];
}

- (void)refreshTable {
    //TODO: refresh your data
    
    [self fetchMovies];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    //Do your stuff here
    // You can also track the direction of UIScrollView here.
    
    if (!self.isMoreDataLoading)
    {
        CGFloat scrollViewContentHeight = self.moviesTableView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight - self.moviesTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.moviesTableView.dragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.moviesTableView.contentSize.height, self.moviesTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight + self.tabBarController.tabBar.frame.size.height);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            [self fetchMovies];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.moviesTableView];
    [view addSubview:self.errorView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.moviesTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.moviesTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.moviesTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.moviesTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.moviesTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.errorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.errorView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.errorView.heightAnchor constraintEqualToConstant:30].active = YES;
    
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

- (void)setupInfiniteScrollView
{
    CGRect frame = CGRectMake(0, self.moviesTableView.contentSize.height, self.moviesTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[FLInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.moviesTableView addSubview:self.loadingMoreView];
    self.loadingMoreView.backgroundColor = [UIColor yellowColor];
    
    
}

-(void)addSearchBar {

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:self];
    searchController.searchResultsUpdater = self;
    self.navigationItem.titleView = searchController.searchBar;
    self.definesPresentationContext = YES;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setupInfiniteScrollView];
    [self addSearchBar];
    
}



@end
