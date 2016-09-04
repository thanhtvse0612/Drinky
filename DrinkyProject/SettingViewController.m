//
//  SettingViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/4/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "SettingViewController.h"
#import "CustomSettingNotificationCell.h"
#import "CustomDefaultSettingCell.h"
#import "UpdateFriendContactViewController.h"
#import "ContactSettingViewController.h"
#import "ThirdPartyNoticesViewController.h"
#import "PrivacyViewController.h"
#import "TermOfUseViewController.h"
#import "AboutViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Setting"];
    [self.navigationController.navigationBar setTranslucent:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
//    [[myAppdelegate homeViewController].tabBar setTranslucent:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Notification Setting";
    } else if (section == 1) {
        return @" Contact Setting";
    } else if (section == 2) {
        return @"Other";
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberRow;
    if (section == 0) {
        numberRow = 2;
    } else if (section == 1) {
        numberRow = 2;
    } else if (section == 2) {
        numberRow = 4;
    }
    return numberRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *identifierString;
    if (indexPath.section == 0) {
        identifierString = @"CustomSettingNotificationCell";
    } else if (indexPath.section == 1) {
        identifierString = @"CustomDefaultSettingCell";
    } else if (indexPath.section == 2) {
        identifierString = @"CustomDefaultSettingCell";
    }
    
    CustomSettingNotificationCell *notificationCell = (CustomSettingNotificationCell *)[_tblView dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    CustomDefaultSettingCell *settingCell = (CustomDefaultSettingCell *)[_tblView dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    if (indexPath.section == 0) {
        if (notificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierString owner:self options:nil];
            notificationCell = [nib firstObject];
        }
        
        if (indexPath.row == 0) {
            notificationCell.lbNameSettingItem.text = @"In-App Notification";
        } else {
            notificationCell.lbNameSettingItem.text = @"In-App Sounds";
        }
        
        cell = notificationCell;
    } else if (indexPath.section == 1) {
        if (settingCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierString owner:self options:nil];
            settingCell = [nib firstObject];
        }
        
        if (indexPath.row == 0) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"Update Contact";
        }   else if (indexPath.row == 1) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"Contact Setting";
        }
        
        cell = settingCell;
    } else if (indexPath.section == 2) {
        if (settingCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierString owner:self options:nil];
            settingCell = [nib firstObject];
        }
        
        if (indexPath.row == 0) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"Term Of Use";
        }   else if (indexPath.row == 1) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"Third Party Notices";
        } else if (indexPath.row == 2) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"Privacy";
        } else if (indexPath.row == 3) {
            settingCell.imgSubImage.image = [UIImage imageNamed:@"ic_forward"];
            settingCell.lbSettingName.text = @"About Drinky";
        }
         cell = settingCell;
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                UpdateFriendContactViewController *updateFriendContactViewController = [[UpdateFriendContactViewController alloc] initWithNibName:@"UpdateFriendContactViewController" bundle:nil];
                [self.navigationController pushViewController:updateFriendContactViewController animated:YES];
                break;
            }
            case 1: {
                ContactSettingViewController *contactSettingViewController = [[ContactSettingViewController alloc] initWithNibName:@"ContactSettingViewController" bundle:nil];
                [self.navigationController pushViewController:contactSettingViewController animated:YES];
                break;
            }
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                TermOfUseViewController *termOfUseViewController = [[TermOfUseViewController alloc] initWithNibName:@"TermOfUseViewController" bundle:nil];
                [self.navigationController pushViewController:termOfUseViewController animated:YES];
                break;
            }
            case 1: {
                ThirdPartyNoticesViewController *thirdPartyNoticesViewController = [[ThirdPartyNoticesViewController alloc] initWithNibName:@"ThirdPartyNoticesViewController" bundle:nil];
                [self.navigationController pushViewController:thirdPartyNoticesViewController animated:YES];
                break;
            }
            case 2: {
                PrivacyViewController *privacyViewController = [[PrivacyViewController alloc] initWithNibName:@"PrivacyViewController" bundle:nil];
                [self.navigationController pushViewController:privacyViewController animated:YES];
                break;
            }
            case 3: {
                AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                [self.navigationController pushViewController:aboutViewController animated:YES];
            }
            default:
                break;
        }

    }
}

@end
