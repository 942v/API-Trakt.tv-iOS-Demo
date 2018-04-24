//
//  TKTMoviesListTableViewCell.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTMoviesListTableViewCell.h"

@import SDWebImage;

#import "TKTMovieIdentifiers.h"
#import "FATMovie.h"
#import "FATMovieLogo.h"

#import "TKTDataManager.h"

@interface TKTMoviesListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) NSURLSessionDataTask *imageDataTask;

@end

@implementation TKTMoviesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Setters

- (void)setMovie:(TKTMovie *)movie {
    
    [self setTitle:movie.title
          subtitle:movie.year.stringValue
          overview:movie.overview];
    [self getLogoWithIdentifier:movie.identifiers.tmdb];
}

- (void)setTitle:(NSString *)title
        subtitle:(NSString *)subtitle
        overview:(NSString *)overview {
    
    self.topLabel.text = title;
    self.bottomLabel.text = subtitle;
    self.overviewLabel.text = overview;
    self.logoImageView.image = NULL;
}

- (void)getLogoWithIdentifier:(NSNumber *)identifier {
    
    if (self.imageDataTask) [self.imageDataTask cancel];
    self.imageDataTask = [[TKTDataManager sharedInstance] GET_movieDetailWithIdentifier:identifier
                                                           success:^(FATMovie *movie) {
                                                               NSURL *imageURL = movie.logos.firstObject.url;
                                                               if (imageURL) [self.logoImageView sd_setImageWithURL:imageURL];
                                                           }
                                                           failure:NULL];
}

@end
