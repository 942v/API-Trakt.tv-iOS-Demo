//
//  TKTHTTPSessionManager.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

@import AFNetworking;

@interface TKTHTTPSessionManager : AFHTTPSessionManager

+ (TKTHTTPSessionManager *)currentSession;

@end
