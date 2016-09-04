//
//  PreviewFriendsViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface PreviewFriendsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (strong, nonatomic) Friend *aFriend;

@end
