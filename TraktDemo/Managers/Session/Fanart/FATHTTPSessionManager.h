//
//  FATHTTPSessionManager.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

@import AFNetworking;

@interface FATHTTPSessionManager : AFHTTPSessionManager

+ (FATHTTPSessionManager *)currentSession;

@end
