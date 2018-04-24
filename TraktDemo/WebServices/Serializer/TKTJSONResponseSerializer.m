//
//  TKTJSONResponseSerializer.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTJSONResponseSerializer.h"

#import "TKTError.h"

@implementation TKTJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    
    id responseToReturn = [super responseObjectForResponse:response
                                                      data:data
                                                     error:error];
    if (!*error) {
        return responseToReturn;
    }
    
    NSError *parsingError;
    NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&parsingError];
    
    if (parsingError) {
        return responseToReturn;
    }
    
    NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
    NSInteger code = ((NSHTTPURLResponse *)response).statusCode;
    NSDictionary *errorData = JSONResponse[@"errors"];
    TKTError *annotatedError = [TKTError newWithDomain:(*error).domain code:code data:errorData userInfo:userInfo];
    
    (*error) = annotatedError;
    
    return responseToReturn;
}

@end
