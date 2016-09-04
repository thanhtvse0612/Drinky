//
//  CustomFriendsCell.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CustomFriendsCell.h"

@implementation CustomFriendsCell

- (void)awakeFromNib {
    // Initialization code
    _imgAvatar.layer.cornerRadius = _imgAvatar.bounds.size.width/2.0f;
    _imgAvatar.layer.borderWidth = 1.0f;
    [_imgAvatar.layer masksToBounds];
    _imgAvatar.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
