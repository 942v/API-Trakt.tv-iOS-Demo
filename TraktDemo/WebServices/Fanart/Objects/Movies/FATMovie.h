//
//  FATMovie.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@class FATMovieLogo;

@interface FATMovie : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSArray <FATMovieLogo *> *logos;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
