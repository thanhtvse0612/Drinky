//
//  InviteViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewStore;
@property (weak, nonatomic) IBOutlet UITableView *tableViewContact;

@end
