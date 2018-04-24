//
//  TKTMovieIdentifiers.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTMovieIdentifiers.h"

@implementation TKTMovieIdentifiers

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSString *trakt = [dictionary objectForKey:@"trakt"];
    NSString *slug = [dictionary objectForKey:@"slug"];
    NSString *imdb = [dictionary objectForKey:@"imdb"];
    NSNumber *tmdb = [dictionary objectForKey:@"tmdb"];
    
    return [[TKTMovieIdentifiers alloc] initWithTrakt:trakt
                                                 slug:slug
                                                 imdb:imdb
                                                 tmdb:tmdb];
}

- (instancetype)initWithTrakt:(NSString *)trakt
                         slug:(NSString *)slug
                         imdb:(NSString *)imdb
                         tmdb:(NSNumber *)tmdb {
    
    self = [super init];
    if (self) {
        if ([trakt isKindOfClass:[NSString class]])_trakt = trakt;
        if ([slug isKindOfClass:[NSString class]])_slug = slug;
        if ([imdb isKindOfClass:[NSString class]])_imdb = imdb;
        if ([tmdb isKindOfClass:[NSNumber class]])_tmdb = tmdb;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _trakt = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"trakt"];
        _slug = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"slug"];
        _imdb = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"imdb"];
        _tmdb = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"tmdb"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_trakt forKey:@"trakt"];
    [aCoder encodeObject:_slug forKey:@"slug"];
    [aCoder encodeObject:_imdb forKey:@"imdb"];
    [aCoder encodeObject:_tmdb forKey:@"tmdb"];
}

@end
