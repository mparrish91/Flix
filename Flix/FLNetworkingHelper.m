//
//  FLNetworkingHelper.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLNetworkingHelper.h"
#import "FLHTTPClient.h"


@implementation FLNetworkingHelper

+ (instancetype)sharedInstance
{
    static FLNetworkingHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FLNetworkingHelper alloc] init];
    });
    return sharedInstance;
}

- (void)fetchTopRatedWithHandler:(FLDataRequestHandler)handler
{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    FLHTTPClient *httpClient = [[FLHTTPClient alloc]initWithURL:url];
    [httpClient performRequestWithHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error)
     {
         
     }
     ];
    
}


- (void)fetchNowPlayingWithHandler:(FLDataRequestHandler)handler
{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    
    FLHTTPClient *httpClient = [[FLHTTPClient alloc]initWithURL:url];
    [httpClient performRequestWithHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error)
     {
         if (data) {
         }
         
         
     }
     ];
    
}


- (void)fetchMovieDetailsWithHandler:(FLDataRequestHandler)handler
{
    
}

@end
