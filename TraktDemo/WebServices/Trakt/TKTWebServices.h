//
//  TKTWebServices.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

@import Foundation;

@class TKTSearch, TKTMovie, TKTMetadata;

@interface TKTWebServices : NSObject

+ (NSURLSessionDataTask *)GET_moviesWithKeywords:(NSString *)keywords
                                            page:(NSNumber *)pageNumber
                                    itemsPerPage:(NSNumber *)itemsPerPage
                                        extended:(NSString *)extended
                                         success:(void (^)(NSArray<TKTSearch *> *searchs, TKTMetadata *metadata))success
                                         failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask *)GET_moviesPopularWithPage:(NSNumber *)pageNumber
                                       itemsPerPage:(NSNumber *)itemsPerPage
                                           extended:(NSString *)extended
                                            success:(void (^)(NSArray<TKTMovie *> *movies, TKTMetadata *metadata))success
                                            failure:(void (^)(NSError *error))failure;

+ (void)setAuthorizationToken:(NSString *)authorizationToken;

@end
