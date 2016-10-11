//
//  FLNetworkingHelper.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLNetworkingHelper.h"

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
    
}


- (void)fetchNowPlayingWithHandler:(FLDataRequestHandler)handler
{
    
}


- (void)fetchMovieDetailsWithHandler:(FLDataRequestHandler)handler
{
    
}

@end
