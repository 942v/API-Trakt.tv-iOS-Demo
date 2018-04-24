//
//  TKTGenericErrorTableViewCell.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTGenericErrorTableViewCell.h"

#import "TKTError.h"

@interface TKTGenericErrorTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end

@implementation TKTGenericErrorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setError:(TKTError *)error
          target:(id)target
   retrySelector:(SEL)selector {
    
    _error = error;
    
    self.titleLabel.text = [error.title stringByAppendingFormat:@" (%ld)", (long)error.code];
    self.descriptionLabel.text = error.message;
    [self.retryButton addTarget:target
                         action:selector
               forControlEvents:UIControlEventTouchUpInside];
}

@end
