//
//  TKTBaseWebServiceObject.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@implementation TKTBaseWebServiceObject

+ (NSString *)classNameString {
    return NSStringFromClass([self class]);
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(NO, @"This method must be subclassed");
    return NULL;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSAssert(NO, @"This method must be subclassed");
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)initWithArchivedVersion:(NSData *)archivedVersion{
    return [NSKeyedUnarchiver unarchiveObjectWithData:archivedVersion];
}

- (NSData *)getArchivedVersion{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end
