//
//  FLMovie.m
//  Flix
//
//  Created by parry on 10/11/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "FLMovie.h"
#import "FLMovie-Internal.h"
//#import "FLBase.m"

@implementation FLMovie

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict
{
    
    NSMutableDictionary *valuesForKeys = [NSMutableDictionary dictionary];
    id value = nil;

    
    if ((value = dict[@"poster_path"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"posterPath"] = FLMovieImageURLFromString(value);
    
    if ((value = dict[@"overview"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"overview"] = value;
    
    if ((value = dict[@"release_date"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"releaseDate"] = [self convertStringToDate:value];
    
    if ((value = dict[@"original_title"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"title"] = value;
    
    if ((value = dict[@"popularity"]) && [value respondsToSelector:@selector(doubleValue)])
        valuesForKeys[@"rating"] = value;
    
    
//    FLPerformSyncOnMainThread(^{
//        [self setValuesForKeysWithDictionary:valuesForKeys];
//    });
    
    [self setValuesForKeysWithDictionary:valuesForKeys];

    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setValuesForKeysWithDictionary:valuesForKeys];
//    });
    

    return self;
}


#pragma mark - Support

NSString* FLMovieImageURLFromString(NSString *str)
{
    NSString *url = [[NSMutableString alloc]initWithString:@"https://image.tmdb.org/t/p/w300/"];
    NSString *returnString = [url stringByAppendingString:str];

    return returnString;
}


- (NSDate *)convertStringToDate: (NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-mm-dd"];
    NSDate *date = [dateFormat dateFromString:str];
    
    return date;
}



@end
