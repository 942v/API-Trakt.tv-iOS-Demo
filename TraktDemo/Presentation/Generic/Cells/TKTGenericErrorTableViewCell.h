//
//  TKTGenericErrorTableViewCell.h
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

@import UIKit;

@class TKTError;

@interface TKTGenericErrorTableViewCell : UITableViewCell

@property (weak, nonatomic, readonly) TKTError *error;

- (void)setError:(TKTError *)error
          target:(id)target
   retrySelector:(SEL)selector;

@end
