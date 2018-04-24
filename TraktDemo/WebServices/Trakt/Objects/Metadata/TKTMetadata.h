//
//  TKTMetadata.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@interface TKTMetadata : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSNumber *currentPage;
@property (nonatomic, copy, readonly) NSNumber *totalPages;
@property (nonatomic, copy, readonly) NSNumber *elementsCount;

@property (nonatomic, assign, readonly, getter=hasMorePages) BOOL morePages;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
