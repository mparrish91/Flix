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




@interface FLMoviesTableViewController ()

@property(strong,readwrite,nonatomic) NSArray *movies;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *moviesTableView;
@property(nonatomic,strong) UISearchBar *movieSearchBar;
@property(nonatomic,strong) UIRefreshControl *refreshControl;


@property(nonatomic,strong) FLInfiniteScrollActivityView *loadingMoreView;

@end

@implementation FLMoviesTableViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.moviesTableView = [[UITableView alloc]init];
    self.movieSearchBar = [[UISearchBar alloc]init];
    
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
    
    
    CGRect frame = CGRectMake(0, self.moviesTableView.contentSize.height, self.moviesTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[FLInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.moviesTableView addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.moviesTableView.contentInset;
    insets.bottom += FLInfiniteScrollActivityView.defaultHeight;
    self.moviesTableView.contentInset = insets;

    
    [self setConstraints];
    [self fetchMovies];
}


- (void)fetchMovies
{
    FLNetworkingHelper *networkingHelper = [[FLNetworkingHelper alloc]init];
    [networkingHelper fetchNowPlayingWithCompletionHandler:^(NSArray *objects, NSError *error)
     {
         self.movies = objects;
     
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.moviesTableView reloadData];
             [self.refreshControl endRefreshing];
             self.isMoreDataLoading = false;
             [self.loadingMoreView startAnimating];
             
             
             if ([[NSThread currentThread] isMainThread]){
                 NSLog(@"In main thread--completion handler");
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
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
    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
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
            
            CGRect frame = CGRectMake(0, self.moviesTableView.contentSize.height, self.moviesTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight);
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
    //    [self initFooterView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    
    self.moviesTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.moviesTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.moviesTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.moviesTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.moviesTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
}

- (NSString *)convertDateToString: (NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.YY"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    
    return dateStr;
}


@end
