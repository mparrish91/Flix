//
//  FLHTTPClient.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLHTTPClient.h"

@interface FLHTTPClient ()

@end


@implementation FLHTTPClient

- (instancetype)initWithURL:(NSURL *)URL {
    if (!(self = [super init]))
        return nil;
    
    _URL = [URL copy];

    return self;
}


- (void)performJSONRequestWithHandler:(FLDataRequestHandler)handler
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:self.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //request
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
            return;
        }
        
        //json
        id JSONObject = nil;
        if (data.length) {
            NSError *serializationError = nil;
            JSONObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
            if (!JSONObject) {
                NSLog(@"Error parsing JSON: %@", serializationError);
            }
        
        if (handler)
            handler(JSONObject, (NSHTTPURLResponse *)response, error);
            
            
        }
    }];
        [dataTask resume];
    
}


@end
