//
//  TKTMovie.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@class TKTMovieIdentifiers;

@interface TKTMovie : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSNumber *year;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) TKTMovieIdentifiers *identifiers;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
