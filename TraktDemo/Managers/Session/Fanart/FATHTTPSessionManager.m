//
//  FATHTTPSessionManager.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

#import "FATHTTPSessionManager.h"

@import AFNetworkActivityLogger;

#import "TKTJSONResponseSerializer.h"

@interface FATHTTPSessionManager ()

@end

@implementation FATHTTPSessionManager

static FATHTTPSessionManager *SINGLETON = NULL;

static BOOL isFirstAccess = YES;

#pragma mark - Public Method

+ (FATHTTPSessionManager *)currentSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] initWithBaseURL:[NSURL URLWithString:FAT_BASE_URL]];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [self currentSession];
}

- (instancetype)copy {
    return [[FATHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:FAT_BASE_URL]];
}

- (instancetype)mutableCopy {
    return [[FATHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:FAT_BASE_URL]];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if(SINGLETON) {
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super initWithBaseURL:url];
    if (self) {
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [self setResponseSerializer:[TKTJSONResponseSerializer serializer]];
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    return self;
}

@end
