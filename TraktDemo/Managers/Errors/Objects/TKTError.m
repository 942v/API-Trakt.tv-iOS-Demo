//
//  TKTError.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTError.h"

@implementation TKTError

+ (instancetype )newWithDomain:(NSErrorDomain)domain code:(NSInteger)code data:(NSDictionary *)data userInfo:(NSDictionary *)userInfo {
    
    NSString *title;
    NSString *message;
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        title = [data objectForKey:@"message"];
        message = [data objectForKey:@"description"];
    }else{
        title = @"Problema del servidor";
        message = @"Ha ocurrido un error inesperado. Por favor, intenta luego.";
    }
    
    return [[TKTError alloc] initWithdomain:domain code:code title:title message:message userInfo:userInfo];
}

- (instancetype)initWithdomain:(NSErrorDomain)domain code:(NSInteger)code title:(NSString *)title message:(NSString *)message userInfo:(NSDictionary *)userInfo {
    
    self = [super initWithDomain:domain code:code userInfo:userInfo];
    if (self) {
        _type = code;
        if ([title isKindOfClass:[NSString class]]) _title = title;
        if ([message isKindOfClass:[NSString class]]) _message = message;
    }
    return self;
}

@end
