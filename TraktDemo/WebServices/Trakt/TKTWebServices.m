//
//  TKTWebServices.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTWebServices.h"

#import "TKTLoggerHelper.h"
#import "TKTHTTPSessionManager.h"

#import "TKTSearch.h"
#import "TKTMovie.h"
#import "TKTMetadata.h"

@implementation TKTWebServices

+ (NSURLSessionDataTask *)GET_moviesWithKeywords:(NSString *)keywords
                                            page:(NSNumber *)pageNumber
                                    itemsPerPage:(NSNumber *)itemsPerPage
                                        extended:(NSString *)extended
                                         success:(void (^)(NSArray<TKTSearch *> *, TKTMetadata *))success
                                         failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (keywords) [parameters setObject:keywords forKey:@"query"];
    if (pageNumber) [parameters setObject:pageNumber forKey:@"page"];
    if (itemsPerPage) [parameters setObject:itemsPerPage forKey:@"limit"];
    if (extended) [parameters setObject:extended forKey:@"extended"];
    
    NSURLSessionDataTask *dataTask = [[TKTHTTPSessionManager currentSession] GET:@"search/movie"
                                                                      parameters:parameters.copy
                                                                        progress:NULL
                                                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                             NSArray *data = responseObject;
                                                                             
                                                                             NSMutableArray <TKTSearch *> *searchs = [NSMutableArray array];
                                                                             for (NSDictionary *searchData in data) {
                                                                                 [searchs addObject:[TKTSearch newWithDictionary:searchData]];
                                                                             }
                                                                             
                                                                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                                                             NSDictionary *headers = response.allHeaderFields;
                                                                             
                                                                             TKTMetadata *metadata = [TKTMetadata newWithDictionary:headers];
                                                                             
                                                                             if (success) success(searchs.copy, metadata);
                                                                         }
                                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                             if (failure) failure(error);
                                                                         }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)GET_moviesPopularWithPage:(NSNumber *)pageNumber
                                       itemsPerPage:(NSNumber *)itemsPerPage
                                           extended:(NSString *)extended
                                            success:(void (^)(NSArray<TKTMovie *> *, TKTMetadata *))success
                                            failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (pageNumber) [parameters setObject:pageNumber forKey:@"page"];
    if (itemsPerPage) [parameters setObject:itemsPerPage forKey:@"limit"];
    if (extended) [parameters setObject:extended forKey:@"extended"];
    
    NSURLSessionDataTask *dataTask = [[TKTHTTPSessionManager currentSession] GET:@"movies/popular"
                                                                      parameters:parameters.copy
                                                                        progress:NULL
                                                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                             NSArray *data = responseObject;
                                                                             
                                                                             NSMutableArray <TKTMovie *> *movies = [NSMutableArray array];
                                                                             for (NSDictionary *movieData in data) {
                                                                                 [movies addObject:[TKTMovie newWithDictionary:movieData]];
                                                                             }
                                                                             
                                                                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                                                             NSDictionary *headers = response.allHeaderFields;
                                                                             
                                                                             TKTMetadata *metadata = [TKTMetadata newWithDictionary:headers];
                                                                             
                                                                             if (success) success(movies.copy, metadata);
                                                                         }
                                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                             if (failure) failure(error);
                                                                         }];
    
    return dataTask;
}

#pragma mark - Setters

+ (void)setAuthorizationToken:(NSString *)authorizationToken {
    
    DDLogDebug(@"authorizationToken: %@", authorizationToken);
    [[TKTHTTPSessionManager manager].requestSerializer setValue:authorizationToken?authorizationToken:NULL forHTTPHeaderField:@"trakt-api-key"];
}

@end
