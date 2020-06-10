//
//  HTTPService.m
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-02.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import "HTTPService.h"

#define URL_BASE "http://localhost:3000"
#define URL_TUTORIALS "/tutorials"
#define URL_COMMENTS "/comments"

@implementation HTTPService
+ (id) instance {
    static HTTPService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc]init];
    }
    
    return sharedInstance;
}

- (void) getTutorials: (nullable onComplete)completionHandler {
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_TUTORIALS]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            NSError *err;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
             
            if (err == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"Data is corrupt, Please try again");
            }
        } else {
            NSLog(@"Network Err: %@", error.debugDescription);
            completionHandler(nil, @"Problem conecting to the server");
        }
        
    }] resume];
}

-(void) getSpecificVideo:(NSString *)videoId :(onGetSpecific)getSpecificHandler {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s%s/%@", URL_BASE, URL_TUTORIALS, URL_COMMENTS, videoId]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            
            NSError *err;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
             NSLog(@"ASDF%@", url);
            if (err == nil) {
                NSLog(@"klklklk");
                getSpecificHandler(json, nil);
            } else {
                getSpecificHandler(nil, @"Data is corrupt, Please try again");
            }
        } else {
            NSLog(@"Network Err: %@", error.debugDescription);
            getSpecificHandler(nil, @"Problem conecting to the server");
        }
        
    }] resume];
}

-(void) postTutorials:(NSString *)videoId :(NSString *)name :(NSString *)comment :(onPost)posthandler {
    NSDictionary *mycomment = @{@"videoId" : videoId, @"username" : name, @"comment" : comment};
    
    NSError *error;
    NSLog(@"test23: %@", videoId);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/comments"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSLog(@"test23445: %@", mycomment);
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mycomment options:0 error:&error];
     NSLog(@"test23445xxxxxx: %@", postData);
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            // gets here
            posthandler();
        }
    }];
    
    [postDataTask resume];
    
}

@end
