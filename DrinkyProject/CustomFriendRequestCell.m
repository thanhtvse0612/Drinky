//
//  CustomFriendCell.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CustomFriendRequestCell.h"
#import "LocalizableDefine.h"

@implementation CustomFriendRequestCell

- (void)awakeFromNib {
    // Initialization code
    [_btnAccept setTitle:NSLocalizedString(ButtonAccept, nil) forState:UIControlStateNormal];
    [_btnCancel setTitle:NSLocalizedString(ButtonCancel, nil) forState:UIControlStateNormal];
    [_imgAvatar setImage:[UIImage imageNamed:@"ic_drinky"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
