//
//  FLHTTPClient.m
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLHTTPClient.h"

@interface FLHTTPClient ()

//@property(strong,readwrite,nonatomic) NSURL *url;
//@property(copy,readonly,nonatomic) NSURL *URL;


@end


@implementation FLHTTPClient

- (instancetype)initWithURL:(NSURL *)URL {
    if (!(self = [super init]))
        return nil;
    
    _URL = [URL copy];

    return self;
}


- (void)performRequestWithHandler:(FLDataRequestHandler)handler
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:self.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
