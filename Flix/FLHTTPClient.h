//
//  FLHTTPClient.h
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FLDataRequestHandler)(id responseObject, NSHTTPURLResponse *urlResponse, NSError *error);


@interface FLHTTPClient : NSObject

@property(copy,readonly,nonatomic) NSURL *URL;

- (instancetype)initWithURL:(NSURL *)URL;
- (void)performJSONRequestWithHandler:(FLDataRequestHandler)handler;




@end
