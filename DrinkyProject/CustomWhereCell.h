//
//  CustomInviteCell.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/18/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWhereCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgStore;
@property (weak, nonatomic) IBOutlet UILabel *lbStoreName;

@property (weak, nonatomic) IBOutlet UILabel *lbStoreAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbRate;
@property (weak, nonatomic) IBOutlet UIImageView *imgPercent;
@property (weak, nonatomic) IBOutlet UILabel *lbPercent;
@property (weak, nonatomic) IBOutlet UIImageView *imgCoffee;
@property (weak, nonatomic) IBOutlet UIImageView *imgUnknown;
@property (weak, nonatomic) IBOutlet UIImageView *imgPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgBean;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end
