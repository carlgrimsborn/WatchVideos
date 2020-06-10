//
//  Video.h
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-05.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Comment;

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSObject
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoIframe;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) NSString *videoIdentifier;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@end

NS_ASSUME_NONNULL_END
