//
//  FATMovieLogo.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "FATMovieLogo.h"

@implementation FATMovieLogo

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSString *urlString = [dictionary objectForKey:@"url"];
    
    return [[FATMovieLogo alloc] initWithURLString:urlString];
}

- (instancetype)initWithURLString:(NSString *)urlString {
    
    self = [super init];
    if (self) {
        if ([urlString isKindOfClass:[NSString class]] && urlString.length>0) _url = [NSURL URLWithString:urlString];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _url = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_url forKey:@"url"];
}

@end
