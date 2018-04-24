//
//  TKTDataManager.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

#import "TKTDataManager.h"

#import "TKTWebServices.h"
#import "FATWebServices.h"

#import "TKTErrorsManager.h"

@interface TKTDataManager ()

@end

@implementation TKTDataManager

static TKTDataManager *SINGLETON = NULL;

static BOOL isFirstAccess = YES;

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (instancetype) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copy {
    return [[TKTDataManager alloc] init];
}

- (instancetype)mutableCopy {
    return [[TKTDataManager alloc] init];
}

- (instancetype) init {
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    if (self) {
        [self setupCredentials];
    }
    return self;
}

#pragma mark - Setup

- (void)setupCredentials {
    [TKTWebServices setAuthorizationToken:TKT_CLIENT_ID];
    [FATWebServices setAPIKey:FAT_API_KEY clientKey:FAT_CLIENT_KEY];
}

#pragma mark - Services

- (NSURLSessionDataTask *)GET_moviesWithSearchString:(NSString *)searchString
                                                page:(NSNumber *)pageNumber
                                        extendedData:(BOOL)extendedData
                                             success:(void (^)(NSArray<TKTSearch *> *, TKTMetadata *))success
                                             failure:(void (^)(TKTError *))failure {
    
    NSString *keywords = [searchString stringByReplacingOccurrencesOfString:@" " withString:@","];
    
    NSURLSessionDataTask *dataTask = [TKTWebServices GET_moviesWithKeywords:keywords
                                                                       page:pageNumber
                                                               itemsPerPage:@10
                                                                   extended:extendedData?@"full":NULL
                                                                    success:^(NSArray<TKTSearch *> *searchs, TKTMetadata *metadata) {
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            if (success)success (searchs, metadata);
                                                                        });
                                                                    }
                                                                    failure:^(NSError *error) {
                                                                        [[TKTErrorsManager sharedInstance] handleError:error failure:^(TKTError *error) {
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                if (failure)failure (error);
                                                                            });
                                                                        }];
                                                                    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)GET_moviesPopularWithPage:(NSNumber *)pageNumber
                                       extendedData:(BOOL)extendedData
                                            success:(void (^)(NSArray<TKTMovie *> *, TKTMetadata *))success
                                            failure:(void (^)(TKTError *))failure {
    
    NSURLSessionDataTask *dataTask = [TKTWebServices GET_moviesPopularWithPage:pageNumber
                                                                  itemsPerPage:@10
                                                                      extended:extendedData?@"full":NULL
                                                                       success:^(NSArray <TKTMovie *> *movies, TKTMetadata *metadata) {
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               if (success)success (movies, metadata);
                                                                           });
                                                                       }
                                                                       failure:^(NSError *error) {
                                                                           [[TKTErrorsManager sharedInstance] handleError:error failure:^(TKTError *error) {
                                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                   if (failure)failure (error);
                                                                               });
                                                                           }];
                                                                       }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)GET_movieDetailWithIdentifier:(NSNumber *)identifier
                                                success:(void (^)(FATMovie *))success
                                                failure:(void (^)(TKTError *))failure {
    
    NSURLSessionDataTask *dataTask = [FATWebServices GET_movieDetailWithIdentifier:identifier
                                                                           success:^(FATMovie *movie) {
                                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                   if (success)success (movie);
                                                                               });
                                                                           }
                                                                           failure:^(NSError *error) {
                                                                               [[TKTErrorsManager sharedInstance] handleError:error failure:^(TKTError *error) {
                                                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                                                       if (failure)failure (error);
                                                                                   });
                                                                               }];
                                                                           }];
    
    return dataTask;
}

@end
