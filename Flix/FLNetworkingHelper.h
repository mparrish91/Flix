//
//  FLNetworkingHelper.h
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FLDataRequestHandler)(id responseObject, NSHTTPURLResponse *urlResponse, NSError *error);


@interface FLNetworkingHelper : NSObject

//- (void)fetchTopRatedWithHandler:(FLDataRequestHandler)handler;

- (void)fetchTopRatedWithCompletionHandler:(void (^)(NSArray *objects, NSError *error))completionHandler;


- (void)fetchNowPlayingWithCompletionHandler:(void (^)(NSArray *objects, NSError *error))completionHandler;

- (void)fetchMovieDetailsWithHandler:(FLDataRequestHandler)handler;


@end
