//
//  FATMovieLogo.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseWebServiceObject.h"

@interface FATMovieLogo : TKTBaseWebServiceObject

@property (nonatomic, copy, readonly) NSURL *url;

+ (instancetype)newWithDictionary:(NSDictionary *)dictionary;

@end
