//
//  SettingViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/4/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
