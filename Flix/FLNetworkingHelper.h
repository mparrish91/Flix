//
//  FLNetworkingHelper.h
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FLDataRequestHandler)(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error);


@interface FLNetworkingHelper : NSObject

- (void)fetchTopRatedWithHandler:(FLDataRequestHandler)handler;
- (void)fetchNowPlayingWithHandler:(FLDataRequestHandler)handler;

- (void)fetchMovieDetailsWithHandler:(FLDataRequestHandler)handler;


@end
