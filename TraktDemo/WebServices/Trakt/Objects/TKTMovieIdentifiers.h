//
//  TKTMovieIdentifiers.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@interface TKTMovieIdentifiers : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSString *trakt;
@property (nonatomic, copy, readonly) NSString *slug;
@property (nonatomic, copy, readonly) NSString *imdb;
@property (nonatomic, copy, readonly) NSNumber *tmdb;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
