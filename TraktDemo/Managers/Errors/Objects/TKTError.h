//
//  TKTError.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

@import Foundation;

// Hey! 942v here. Dude don't forget to add this case to the big if in the implementation file in the method called getTypeForCode: :)
typedef enum : NSInteger {
    TKTErrorTypeGeneric,
    TKTErrorTypeUnauthorizedToken = 401,
    TKTErrorTypeExpiredToken = 420,
    TKTErrorTypeAccountNotConfirmedByCellphoneNumber = 460,
    TKTErrorTypeAccountNotConfirmedByFacebook = 461,
    TKTErrorTypeNoNetworkConnectionError = -1009,
    TKTErrorTypeNetworkConnectionError = -1005,
    TKTErrorTypeNetworkConnectionTimeOut = -1001,
} TKTErrorType;

@interface TKTError : NSError

@property (nonatomic, assign, readonly) TKTErrorType type;
@property (nonatomic, strong, readonly) NSString * title;
@property (nonatomic, strong, readonly) NSString * message;

+ (instancetype )newWithDomain:(NSErrorDomain)domain code:(NSInteger)code data:(NSDictionary *)data userInfo:(NSDictionary *)userInfo;
- (instancetype)initWithdomain:(NSErrorDomain)domain code:(NSInteger)code title:(NSString *)title message:(NSString *)message userInfo:(NSDictionary *)userInfo;

@end
