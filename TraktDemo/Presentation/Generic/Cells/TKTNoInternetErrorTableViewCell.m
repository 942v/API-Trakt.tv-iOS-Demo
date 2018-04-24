//
//  TKTNoInternetErrorTableViewCell.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTNoInternetErrorTableViewCell.h"

#import "TKTError.h"

@interface TKTNoInternetErrorTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation TKTNoInternetErrorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setError:(TKTError *)error {
    
    _error = error;
    
    self.titleLabel.text = error.title;
    self.descriptionLabel.text = error.message;
}

@end
