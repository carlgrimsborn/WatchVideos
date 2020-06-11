//
//  CommentCell.m
//  DevslopesTutorials
//
//  Created by Carl Grimsborn on 2020-06-08.
//  Copyright © 2020 Carl Grimsborn. All rights reserved.
//

#import "CommentCell.h"
@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cellView.layer setBorderWidth: 1 ];
    self.cellView.layer.borderColor = UIColor.systemGray4Color.CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)updateUI:(NSString *)comment: (NSString*)username {
    self.commentLbl.text = comment;
    self.usernameLbl.text = username;
}

@end
