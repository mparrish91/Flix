//
//  FLMovie.m
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovie.h"
#import "FLMovie-Internal.h"

@implementation FLMovie

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict
{
    
    NSMutableDictionary *valuesForKeys = [NSMutableDictionary dictionary];
    id value = nil;

    
    if ((value = dict[@"poster_path"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"posterImage"] = value;
    
    if ((value = dict[@"overview"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"description"] = value;
    
    if ((value = dict[@"release_date"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"releaseDate"] = value;
    
    if ((value = dict[@"original_title"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"title"] = value;
    
    if ((value = dict[@"popularity"]) && [value respondsToSelector:@selector(doubleValue)])
        valuesForKeys[@"rating"] = @([value doubleValue]);
    

    
    return self;
}


#pragma mark - Support

NSString* FLMovieImageURLFromString(NSString *str)
{
    
    NSString *returnString = @"https://image.tmdb.org/t/p/w500/";
    
    [returnString stringByAppendingString:str];

    return returnString;
}



@end
