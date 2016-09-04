//
//  CustomFriendCell.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueButton.h"

@interface CustomFriendRequestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet BlueButton *btnAccept;
@property (weak, nonatomic) IBOutlet BlueButton *btnCancel;

@end
