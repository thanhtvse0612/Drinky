//
//  CustomInvitationCell.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CustomInvitationCell.h"
#import "Utilities.h"

@implementation CustomInvitationCell

- (void)awakeFromNib {
    // Initialization code
    _cellView.layer.cornerRadius = 5.f;
    _cellView.backgroundColor = [[Utilities shareInstance] colorWithHex:colorPrimaryLight];
    _cellView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _cellView.layer.borderWidth = .5f;
    
    _btnAccept.backgroundColor =  [[Utilities shareInstance] colorWithHex:colorPrimaryDark];
    _btnAccept.layer.cornerRadius = 5.0f;
    [_btnAccept setTitle:@"Accept" forState:UIControlStateNormal];
    _btnDecline.backgroundColor =  [[Utilities shareInstance] colorWithHex:colorPrimaryDark];
    _btnDecline.layer.cornerRadius = 5.0f;
    [_btnDecline setTitle:@"Decline" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
