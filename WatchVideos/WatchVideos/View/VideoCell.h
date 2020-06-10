//
//  VideoCell.h
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-04.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Video;

@interface VideoCell : UITableViewCell
- (void)updateUI:(nonnull Video*)video;
@end

NS_ASSUME_NONNULL_END
