//
//  TKTSearch.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTSearch.h"

#import "TKTMovie.h"

@implementation TKTSearch

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSString *type = [dictionary objectForKey:@"type"];
    NSNumber *score = [dictionary objectForKey:@"score"];
    NSDictionary *movieData = [dictionary objectForKey:@"movie"];
    
    return [[TKTSearch alloc] initWithType:type
                                     score:score
                                 movieData:movieData];
}

- (instancetype)initWithType:(NSString *)type
                       score:(NSNumber *)score
                   movieData:(NSDictionary *)movieData {
    
    self = [super init];
    if (self) {
        if ([type isKindOfClass:[NSString class]])_type = type;
        if ([score isKindOfClass:[NSNumber class]])_score = score;
        if ([movieData isKindOfClass:[NSDictionary class]])_movie = [TKTMovie newWithDictionary:movieData];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _type = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"type"];
        _score = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"score"];
        _movie = [aDecoder decodeObjectOfClass:[TKTMovie class] forKey:@"movie"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_score forKey:@"score"];
    [aCoder encodeObject:_movie forKey:@"movie"];
}

@end
