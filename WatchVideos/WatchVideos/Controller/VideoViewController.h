//
//  VideoViewController.h
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-06.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//
    
#import <UIKit/UIKit.h>
@class Video;
NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : UIViewController <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate> 
@property (nonatomic, strong) Video *video;
@end

NS_ASSUME_NONNULL_END
