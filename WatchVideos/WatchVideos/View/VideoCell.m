//
//  VideoCell.m
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-04.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import "VideoCell.h"
#import "Video.h"

@interface VideoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.cellView.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [[UIColor colorWithRed:157.0 / 255.0 green:157.0 / 255.0  blue:157.0 / 255.0  alpha:0.8] CGColor];
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.0);

}

- (void)updateUI:(nonnull Video*)video {
    self.titleLbl.text = video.videoTitle;
    self.descLbl.text = video.videoDescription;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.thumbnailUrl]]];
    self.thumbImg.image = image;
}

@end
