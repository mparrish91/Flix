//
//  FLNetworkingHelper.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLNetworkingHelper.h"
#import "FLHTTPClient.h"
#import "FLMovie.h"

@interface FLNetworkingHelper()

@property (assign) int offset;

@end

@implementation FLNetworkingHelper


-(id)init {
    if (self = [super init]) {
        _offset = 1;
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static FLNetworkingHelper *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FLNetworkingHelper alloc] init];
    });
    return sharedInstance;
}

- (void)fetchTopRatedWithCompletionHandler:(void (^)(NSArray *objects, NSError *error))completionHandler
{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    FLHTTPClient *httpClient = [[FLHTTPClient alloc]initWithURL:url];
    
    NSHTTPURLResponse *response=nil;
    NSError *error = nil;
    
    
    //TODO: handle the urlrespnse and error
    [httpClient performJSONRequestWithHandler:^(id responseObject, NSHTTPURLResponse *response, NSError *error)
     {
         
         
         NSMutableArray *objects = nil;
         
         if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *objectRepresentations = responseObject[@"results"];
             objects = [NSMutableArray arrayWithCapacity:objectRepresentations.count];
             
             for (NSDictionary *dict in objectRepresentations) {
                 FLMovie *object = [[FLMovie alloc] initWithServerRepresentation:dict];
                 if (object) [objects addObject:object];
             }
             
         }
         
         self.offset++;

        if (completionHandler)
            completionHandler(objects, error);
         
     }];
}


- (void)fetchNowPlayingWithCompletionHandler:(void (^)(NSArray *objects, NSError *error))completionHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&page=%d", self.offset]];

    
    FLHTTPClient *httpClient = [[FLHTTPClient alloc]initWithURL:url];
    
    NSHTTPURLResponse *response=nil;
    NSError *error = nil;
    
    
    //TODO: handle the urlresponse and error
    [httpClient performJSONRequestWithHandler:^(id responseObject, NSHTTPURLResponse *response, NSError *error)
     {
         
         NSMutableArray *objects = nil;
         
         if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *objectRepresentations = responseObject[@"results"];
             objects = [NSMutableArray arrayWithCapacity:objectRepresentations.count];
             
             for (NSDictionary *dict in objectRepresentations) {
                 FLMovie *object = [[FLMovie alloc] initWithServerRepresentation:dict];
                 if (object) [objects addObject:object];
             }
         }
         
         self.offset++;

             if (completionHandler)
                 completionHandler(objects, error);
         
     }];
    
}


- (void)fetchMovieDetailsWithHandler:(FLDataRequestHandler)handler
{
    
}

@end
