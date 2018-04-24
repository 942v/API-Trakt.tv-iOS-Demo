//
//  FATWebServices.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

@import Foundation;

@class FATMovie;

@interface FATWebServices : NSObject

+ (NSURLSessionDataTask *)GET_movieDetailWithIdentifier:(NSNumber *)identifier
                                            success:(void (^)(FATMovie *movie))success
                                            failure:(void (^)(NSError *error))failure;

+ (void)setAPIKey:(NSString *)apiKey
        clientKey:(NSString *)clientKey;

@end
