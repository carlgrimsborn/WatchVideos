//
//  CommentCell.h
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-08.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
- (void)updateUI:(nonnull NSString*)comment:(nonnull NSString*)username;
@end

NS_ASSUME_NONNULL_END
