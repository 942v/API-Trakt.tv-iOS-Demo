//
//  TKTErrorsManager.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

#import "TKTErrorsManager.h"

@import AFNetworking;
@import Reachability;

#import "TKTLoggerHelper.h"
#import "TKTErrorsManagerNotificationsIndex.h"

@interface TKTErrorsManager ()

@property (nonatomic, copy) Reachability *internetConnectionReach;

@end

@implementation TKTErrorsManager

static TKTErrorsManager *SINGLETON = NULL;

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
    return [[TKTErrorsManager alloc] init];
}

- (instancetype)mutableCopy {
    return [[TKTErrorsManager alloc] init];
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

    }
    return self;
}

- (void)handleError:(NSError *)error failure:(void (^)(TKTError *))failure {
    
    DDLogInfo(@"TKTErrorsManager Error: %@", error);
    
    TKTError *errorObject;
    NSInteger errorCode = error.code;
    
    if ([error isKindOfClass:[TKTError class]]) {
        errorObject = (TKTError *)error;
    } else {
        errorObject = [[TKTError alloc] initWithdomain:error.domain code:errorCode title:@"Error" message:error.localizedDescription userInfo:error.userInfo];
    }

    DDLogInfo(@"Error code: %ld", (long)errorCode);
    DDLogInfo(@"Error localized description: %@", error.localizedDescription);
    
    switch (errorCode) {
        case TKTErrorTypeUnauthorizedToken: {
            break;
        }
        case TKTErrorTypeNoNetworkConnectionError: {
            [self doNoConnectionErrorProtocol];
            break;
        }
        case TKTErrorTypeNetworkConnectionError: {
            [self doNoConnectionErrorProtocol];
            break;
        }
        case TKTErrorTypeNetworkConnectionTimeOut: {
            [self doNoConnectionErrorProtocol];
            break;
        }
        default:
            break;
            // Other API Errors that you want to explicitly handle.
    }
    if (failure) failure(errorObject);
}

- (void)doNoConnectionErrorProtocol {
    
    [TKTErrorsManager postShoutOutToKey:TKTNotificationKeyErrorNoConnection];
    
    if (!self.internetConnectionReach) {
        self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
        
        [self.internetConnectionReach setReachableBlock:^(Reachability * reachability) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [TKTErrorsManager postShoutOutToKey:TKTNotificationKeyInternetIsReachable];
            });
        }];
        
        [self.internetConnectionReach startNotifier];
    }
}

#pragma mark - Helpers

+ (void)postShoutOutToKey:(NSString *)key {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:NULL];
}

@end
