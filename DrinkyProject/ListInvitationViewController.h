//
//  ListInvitationViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ListInvitationViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnToMe;
@property (weak, nonatomic) IBOutlet UIButton *btnFromMe;
@property (weak, nonatomic) IBOutlet UIView *viewAll;
@property (weak, nonatomic) IBOutlet UITableView *tblAll;
@property (weak, nonatomic) IBOutlet UIView *viewNavigation;
@property (weak, nonatomic) IBOutlet UIView *viewSelection;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end
