//
//  TKTMovie.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTMovie.h"

#import "TKTMovieIdentifiers.h"

@implementation TKTMovie

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSString *title = [dictionary objectForKey:@"title"];
    NSNumber *year = [dictionary objectForKey:@"year"];
    NSString *overview = [dictionary objectForKey:@"overview"];
    NSDictionary *identifiersData = [dictionary objectForKey:@"ids"];
    
    return [[TKTMovie alloc] initWithTitle:title
                                      year:year
                                  overview:overview
                           identifiersData:identifiersData];
}

- (instancetype)initWithTitle:(NSString *)title
                         year:(NSNumber *)year
                     overview:(NSString *)overview
              identifiersData:(NSDictionary *)identifiersData {
    
    self = [super init];
    if (self) {
        if ([title isKindOfClass:[NSString class]])_title = title;
        if ([year isKindOfClass:[NSNumber class]])_year = year;
        if ([overview isKindOfClass:[NSString class]])_overview = overview;
        if ([identifiersData isKindOfClass:[NSDictionary class]])_identifiers = [TKTMovieIdentifiers newWithDictionary:identifiersData];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _year = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"year"];
        _overview = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"overview"];
        _identifiers = [aDecoder decodeObjectOfClass:[TKTMovieIdentifiers class] forKey:@"identifiers"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_year forKey:@"year"];
    [aCoder encodeObject:_overview forKey:@"overview"];
    [aCoder encodeObject:_identifiers forKey:@"identifiers"];
}

@end
