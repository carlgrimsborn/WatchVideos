//
//  VideoViewController.m
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-06.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import "VideoViewController.h"
#import "HTTPService.h"
#import "Video.h"
#import "CommentCell.h"


@interface VideoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

//comments

@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UIView *borderView;

@property (nonatomic, strong) NSString *valueForTextInput;
@property (nonatomic, strong) NSString *valueForVideoIdentifier;
@property (nonatomic, strong) NSMutableArray *valueForVideoCommentsArray;
@end

@implementation VideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSLog(@"DATA, %@", self.video.videoIdentifier);
    


    self.valueForVideoIdentifier = self.video.videoIdentifier;
    
    self.commentTableView.dataSource = self;
    self.commentTableView.delegate = self;
  
    
    self.webView.delegate = self;
    
    self.addCommentTextField.borderStyle = UITextBorderStyleNone;
    self.addCommentTextField.layer.borderWidth = 0;
    [self.addCommentTextField addTarget:self action:@selector(didChange:valuesAtIndexes:forKey:) forControlEvents:UIControlEventEditingChanged];
    [self.addCommentTextField addTarget:self action:@selector(endEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.titleLbl.text = self.video.videoTitle;
    self.descLbl.text = self.video.videoDescription;
    [self.webView loadHTMLString:self.video.videoIframe baseURL:nil];
    
    [self getCommentsData];
}

-(void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    self.valueForTextInput = self.addCommentTextField.text;
}

-(void)endEditing :(UITextField *) textField{
    [textField setText:@""];
 
    [[HTTPService instance]postTutorials: self.valueForVideoIdentifier :@"testuser" : self.valueForTextInput  :^{
        [self getCommentsData];
        NSLog(@"gets here%@", self.valueForVideoCommentsArray);
    }];
    [textField resignFirstResponder];
}

-(void)getCommentsData {
    [[HTTPService instance]getSpecificVideo: self.valueForVideoIdentifier :^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
               if (dataArray) {
                    NSMutableArray *commentsArr = [[NSMutableArray alloc]init];
                   for (NSDictionary *d in dataArray) {
                      
                       NSMutableArray *collectibleCommentsArr = [[NSMutableArray alloc]init];
                       [collectibleCommentsArr addObject:[d objectForKey:@"videoId"]];
                       [collectibleCommentsArr addObject:[d objectForKey:@"username"]];
                       [collectibleCommentsArr addObject:[d objectForKey:@"comment"]];
                       [commentsArr addObject:collectibleCommentsArr];
                   }
                   self.valueForVideoCommentsArray = commentsArr;
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                               [self.commentTableView reloadData];
               });
               }
           }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *css = @".container {position: relative;width: 100%;height: 0;padding-bottom: 56.25%;}.video {position: absolute;top: 0;left: 0;width: 100%;height: 100%;}";
       NSString* js = [NSString stringWithFormat:
                   @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
       NSLog(@"js:\n%@",js);
       [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:@"commentmain"];
    
    if (!cell) {
        cell = [[CommentCell alloc]init];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *commentCell = (CommentCell*)cell;
    if (self.valueForVideoCommentsArray.count > 0) {
       
        NSMutableArray *comment = [self.valueForVideoCommentsArray objectAtIndex:indexPath.item];
        NSString *commentDescription = [comment objectAtIndex:2];
         NSString *commentUserName = [comment objectAtIndex:1];
        [commentCell updateUI:commentDescription :commentUserName];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.valueForVideoCommentsArray > 0) {
    return self.valueForVideoCommentsArray.count;
    } else return 0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
