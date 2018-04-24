//
//  FATWebServices.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "FATWebServices.h"

#import "TKTLoggerHelper.h"
#import "FATHTTPSessionManager.h"

#import "FATMovie.h"

@implementation FATWebServices

+ (NSURLSessionDataTask *)GET_movieDetailWithIdentifier:(NSNumber *)identifier
                                                success:(void (^)(FATMovie *))success
                                                failure:(void (^)(NSError *))failure {
    
    NSURLSessionDataTask *dataTask = [[FATHTTPSessionManager currentSession] GET:[NSString stringWithFormat:@"movies/%@", identifier.stringValue]
                                                                      parameters:NULL
                                                                        progress:NULL
                                                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                             NSDictionary *data = responseObject;
                                                                             
                                                                             FATMovie *movie = [FATMovie newWithDictionary:data];
                                                                             
                                                                             if (success) success(movie);
                                                                         }
                                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                             if (failure) failure(error);
                                                                         }];
    
    return dataTask;
}

#pragma mark - Setters

+ (void)setAPIKey:(NSString *)apiKey
        clientKey:(NSString *)clientKey {
    
    DDLogDebug(@"apiKey: %@ \nclientKey: %@", apiKey, clientKey);
    [[FATHTTPSessionManager manager].requestSerializer setValue:apiKey?apiKey:NULL forHTTPHeaderField:@"api-key"];
    [[FATHTTPSessionManager manager].requestSerializer setValue:clientKey?clientKey:NULL forHTTPHeaderField:@"client-key"];
}

@end
