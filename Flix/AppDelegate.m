//
//  AppDelegate.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "AppDelegate.h"
#import "FLNetworkingHelper.h"
#import "FLMovie.h"

#import "FLMoviesTableViewController.h"
#import "FLMovieDetailViewController.h"
#import "FLTabBarController.h"



@interface AppDelegate ()
{
FLTabBarController *tabBarController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    tabBarController = [[FLTabBarController alloc] init];
    
    UINavigationController *nav;
    FLMovieDetailViewController *movieDetailVC =[[FLMovieDetailViewController alloc]init];
    nav = [[UINavigationController alloc]initWithRootViewController:movieDetailVC];
    movieDetailVC.tabBarItem.title = @"In Theaters";
    movieDetailVC.tabBarItem.image = [UIImage imageNamed:@"ticket"];
    nav.navigationBar.hidden = YES;
    
    
    FLMoviesTableViewController *moviesVC =[[FLMoviesTableViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:moviesVC];
    nav2.navigationBar.hidden = YES;

    moviesVC.tabBarItem.title = @"Top Rated";
    moviesVC.tabBarItem.image = [UIImage imageNamed:@"star"];

    
    
    NSArray *viewControllerArray = [NSArray arrayWithObjects:nav, nav2, nil];
    [tabBarController setViewControllers:viewControllerArray];
    

    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    
    
//    [self.window addSubview:[tabBarController view]];
    
//    FLNetworkingHelper *networkingHelper = [[FLNetworkingHelper alloc]init];
//    [networkingHelper fetchNwPlayingWithCompletionHandler:^(NSArray *objects, NSError *error)
//     {
//        
//        NSLog(@"%@",objects);
//        
//    }
//     ];
//    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
