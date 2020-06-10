//
//  HTTPService.h
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-02.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// callback
typedef void (^onComplete)(NSArray * __nullable dataArray, NSString * __nullable errMessage);

typedef void (^onPost)(void);

typedef void (^onGetSpecific)(NSArray * __nullable dataArray, NSString * __nullable errMessage);

@interface HTTPService : NSObject
 
+ (id) instance;
- (void) getTutorials: (nullable onComplete)completionHandler;
- (void) postTutorials: (NSString*) videoId: (NSString*)name : (NSString*)comment : (nullable onPost)posthandler;
-(void) getSpecificVideo: (NSString*) videoId: (nullable onGetSpecific)getSpecificHandler;
@end

NS_ASSUME_NONNULL_END
