//
//  FLMoviesTableViewController.h
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLMoviesTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic,assign) BOOL isTopRated;



@end
