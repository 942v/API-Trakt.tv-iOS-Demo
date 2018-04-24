//
//  TKTDataManager.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

@import Foundation;

@class TKTSearch, TKTMovie, TKTMetadata;
@class FATMovie;
@class TKTError;

@interface TKTDataManager : NSObject

+ (TKTDataManager *)sharedInstance;

- (NSURLSessionDataTask *)GET_moviesWithSearchString:(NSString *)searchString
                                                page:(NSNumber *)pageNumber
                                        extendedData:(BOOL)extendedData
                                             success:(void (^)(NSArray<TKTSearch *> *searchs, TKTMetadata *metadata))success
                                             failure:(void (^)(TKTError *error))failure;

- (NSURLSessionDataTask *)GET_moviesPopularWithPage:(NSNumber *)pageNumber
                                       extendedData:(BOOL)extendedData
                                            success:(void (^)(NSArray<TKTMovie *> *movies, TKTMetadata *metadata))success
                                            failure:(void (^)(TKTError *error))failure;

- (NSURLSessionDataTask *)GET_movieDetailWithIdentifier:(NSNumber *)identifier
                                                success:(void (^)(FATMovie *movie))success
                                                failure:(void (^)(TKTError *error))failure;

@end
