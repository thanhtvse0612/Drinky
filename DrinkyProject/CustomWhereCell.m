//
//  CustomInviteCell.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/18/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CustomWhereCell.h"
#import "Utilities.h"

@implementation CustomWhereCell

- (void)awakeFromNib {
    // Initialization code
    _cellView.layer.cornerRadius = 10.f;
    _cellView.backgroundColor = [[Utilities shareInstance] colorWithHex:0x666666];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
