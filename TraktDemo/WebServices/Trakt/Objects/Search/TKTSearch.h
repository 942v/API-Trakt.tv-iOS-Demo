//
//  TKTSearch.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@class TKTMovie;

@interface TKTSearch : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSNumber *score;
@property (nonatomic, copy, readonly) TKTMovie *movie;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
