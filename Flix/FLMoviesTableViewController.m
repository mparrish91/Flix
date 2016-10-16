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




@interface FLMoviesTableViewController ()

@property(strong,readwrite,nonatomic) NSArray *movies;
@property(nonatomic,strong) UITableView *moviesTableView;
@property(nonatomic,strong) UISearchBar *movieSearchBar;

@property (nonatomic,assign) BOOL isMoreDataLoading;


@end

@implementation FLMoviesTableViewController


#pragma mark - NSObject

- (id)initWithMovies:(NSArray *)movieArray
{
    self.moviesTableView = [[UITableView alloc]init];
    self.movieSearchBar = [[UISearchBar alloc]init];

    
    self = [super init];
    if(self) {
        _movies = movieArray;
    }
    return self;
}

#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    self.movieSearchBar.frame = CGRectMake(0, 0, 320, 50);
}

- (void)fetchMovies
{
    
    FLNetworkingHelper *networkingHelper = [[FLNetworkingHelper alloc]init];
    [networkingHelper fetchNwPlayingWithCompletionHandler:^(NSArray *objects, NSError *error)
     {
         self.movies = objects;
         
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
    cell.overviewLabel.text = [self convertDateToString:movie.releaseDate];
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
    
    [self fetchTumblrPosts];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    //Do your stuff here
    // You can also track the direction of UIScrollView here.
    
    if (!self.isMoreDataLoading)
    {
        CGFloat scrollViewContentHeight = self.postsTableView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight - self.postsTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.postsTableView.dragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.postsTableView.contentSize.height, self.postsTableView.bounds.size.width, TFInfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            
            [self fetchTumblrPosts];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.postsTableView];
    //    [self initFooterView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    
    self..translatesAutoresizingMaskIntoConstraints = false;
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
