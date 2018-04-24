//
//  TKTErrorsManager.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//
//

@import Foundation;

#import "TKTError.h"

@interface TKTErrorsManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (TKTErrorsManager *)sharedInstance;

- (void)handleError:(NSError *)error failure:(void (^)(TKTError *error))failure;

@end
