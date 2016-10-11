//
//  FLHTTPClient.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLHTTPClient.h"

@interface FLHTTPClient ()

@property(strong,readwrite,nonatomic) NSURL *url;

@end


@implementation FLHTTPClient

- (void)performRequestWithHandler:(FLDataRequestHandler)handler
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:self.url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
            return;
        }
        
        if (handler)
            handler(data, (NSHTTPURLResponse *)response, error);

        
    }];
    

dispatch_async(dispatch_get_main_queue(), ^{
    [dataTask resume];
});

}


@end
