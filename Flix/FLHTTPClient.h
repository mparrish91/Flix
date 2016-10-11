//
//  FLHTTPClient.h
//  Flix
//
//  Created by parry on 10/9/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FLDataRequestHandler)(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error);


@interface FLHTTPClient : NSObject



- (void)performRequestWithHandler:(FLDataRequestHandler)handler;


@end
