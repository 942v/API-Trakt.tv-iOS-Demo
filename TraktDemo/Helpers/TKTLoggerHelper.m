//
//  TKTLoggerHelper.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTLoggerHelper.h"

#ifdef DEBUG
const int ddLogLevel = DDLogFlagVerbose | DDLogFlagDebug | DDLogFlagInfo | DDLogFlagWarning | DDLogFlagError;
#else
const int ddLogLevel = DDLogFlagWarning | DDLogFlagError;
#endif

@implementation TKTLoggerHelper

@end
