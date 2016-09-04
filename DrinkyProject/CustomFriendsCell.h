//
//  CustomFriendsCell.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"

@interface CustomFriendsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet Checkbox *viewCheckBox;

@end
