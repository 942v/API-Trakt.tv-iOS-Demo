//
//  FATMovie.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "FATMovie.h"

#import "FATMovieLogo.h"

@implementation FATMovie

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary {
    
    NSArray *logosData = [dictionary objectForKey:@"hdmovielogo"];
    
    return [[FATMovie alloc] initWithLogosData:logosData];
}

- (instancetype)initWithLogosData:(NSArray *)logosData {
    
    self = [super init];
    if (self) {
        if ([logosData isKindOfClass:[NSArray class]]) {
            NSMutableArray <FATMovieLogo *> *logos = [NSMutableArray array];
            for (NSDictionary *logoData in logosData) {
                FATMovieLogo *logo = [FATMovieLogo newWithDictionary:logoData];
                if (logo) [logos addObject:logo];
            }
            _logos = logos.copy;
        }
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _logos = [aDecoder decodeObjectOfClass:[FATMovieLogo class] forKey:@"logos"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_logos forKey:@"logos"];
}

@end
