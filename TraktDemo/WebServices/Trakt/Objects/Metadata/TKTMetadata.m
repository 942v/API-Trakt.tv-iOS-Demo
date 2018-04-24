//
//  TKTMetadata.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTMetadata.h"

@implementation TKTMetadata

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSString *currentPage = [dictionary objectForKey:@"x-pagination-page"];
    NSString *totalPages = [dictionary objectForKey:@"x-pagination-page-count"];
    NSString *elementsCount = [dictionary objectForKey:@"x-pagination-item-count"];
    
    return [[TKTMetadata alloc] initWithCurrentPage:currentPage
                                           totalPages:totalPages
                                        elementsCount:elementsCount];
}

- (instancetype)initWithCurrentPage:(NSString *)currentPage
                         totalPages:(NSString *)totalPages
                      elementsCount:(NSString *)elementsCount {
    
    self = [super init];
    if (self) {
        if ([currentPage isKindOfClass:[NSString class]])_currentPage = [NSNumber numberWithInteger:currentPage.integerValue];
        if ([totalPages isKindOfClass:[NSString class]])_totalPages = [NSNumber numberWithInteger:totalPages.integerValue];
        if ([elementsCount isKindOfClass:[NSString class]])_elementsCount = [NSNumber numberWithInteger:elementsCount.integerValue];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _currentPage = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"currentPage"];
        _totalPages = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"totalPages"];
        _elementsCount = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"elementsCount"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_totalPages forKey:@"totalPages"];
    [aCoder encodeObject:_elementsCount forKey:@"elementsCount"];
}

#pragma mark - Extras
#pragma mark Getters

- (BOOL)hasMorePages {
    
    return self.currentPage.unsignedIntegerValue<self.totalPages.unsignedIntegerValue;
}

@end
