//
//  CustomInvitationCell.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomInvitationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIImageView *imgInvitation;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbWhoInvite;
@property (weak, nonatomic) IBOutlet UILabel *lbTimeInvitation;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberPeopleInvitation;
@property (weak, nonatomic) IBOutlet UILabel *lbWhere;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnDecline;

@end
