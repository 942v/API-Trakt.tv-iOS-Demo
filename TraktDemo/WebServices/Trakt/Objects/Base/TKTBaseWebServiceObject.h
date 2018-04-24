//
//  TKTBaseWebServiceObject.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

@import Foundation;

@interface TKTBaseWebServiceObject : NSObject <NSSecureCoding>

+ (NSString *)classNameString;

+ (instancetype)initWithArchivedVersion:(NSData *)archivedVersion;

- (NSData *)getArchivedVersion;

@end
