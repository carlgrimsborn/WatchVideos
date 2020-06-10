//
//  ViewController.m
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-02.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "Video.h"
#import "VideoCell.h"
#import "VideoViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *videoList;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.videoList = [[NSArray alloc]init];
    
    // getTutorials is a callback and we get values from it
    [[HTTPService instance]getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if (dataArray) {
            NSLog(@"Array: %@", dataArray.debugDescription);
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            //fast enumeration
            for (NSDictionary *d in dataArray) {
                Video *vid = [[Video alloc]init];
                NSMutableArray *collectibleCommentsArr = [[NSMutableArray alloc]init];
                vid.videoTitle = [d objectForKey:@"title"];
                vid.videoDescription = [d objectForKey:@"description"];
                vid.thumbnailUrl = [d objectForKey:@"thumbnail"];
                vid.videoIframe = [d objectForKey:@"iframe"];
                vid.videoIdentifier = [d objectForKey:@"id"];
                if ([[d objectForKey:@"comments"] count] >= 1) {
                for (NSDictionary *c in [d objectForKey:@"comments"]) {
                    NSMutableArray *commentArray = [[NSMutableArray alloc]init];
                    [commentArray addObject:[c objectForKey:@"videoId"]];
                    [commentArray addObject:[c objectForKey:@"username"]];
                    [commentArray addObject:[c objectForKey:@"comment"]];
                    [collectibleCommentsArr addObject:commentArray];
                   
                }}
                vid.commentsArray = collectibleCommentsArr;
                [arr addObject:vid];
            }
            self.videoList = arr;
            
            [self updateTableData];
        
        } else if (errMessage) {
            //Display alert to user
            NSLog(@"My error: %@", errMessage);
        }
    }];
}

-(void) updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell * cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:@"main"];
    
    if (!cell) {
        cell = [[VideoCell alloc]init];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //finding the right row to use from our declared array (data from backend)
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    
    //making a videocell from cell constructor property
    VideoCell *vidcell = (VideoCell*)cell;
    
    //updating that cell with our data from video using our method
    [vidcell updateUI:video];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"videoViewController" sender:video];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    VideoViewController *vc = (VideoViewController*)segue.destinationViewController;
    Video *video = (Video*)sender;
    
    vc.video = video;
}

@end
