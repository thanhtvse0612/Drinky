//
//  FriendRequestViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMPopupSegue.h"
#import "CCMBorderView.h"
#import "CCMPopupTransitioning.h"
@interface FriendRequestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UILabel *lbFriendRequest;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
