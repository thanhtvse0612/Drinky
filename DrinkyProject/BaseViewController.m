//
//  BaseViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "BaseViewController.h"
#import "ListInvitationViewController.h"
#import "BBBadgeBarButtonItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBarButon];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Invite
- (void)addBarButon {
    // If you want your BarButtonItem to handle touch event and click, use a UIButton as customView
    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    // Add your action to your button
    [customButton addTarget:self action:@selector(inviteNewMeeting) forControlEvents:UIControlEventTouchUpInside];
    // Customize your button as you want, with an image if you have a pictogram to display for example
    [customButton setImage:[UIImage imageNamed:@"ic_new_invite"] forState:UIControlStateNormal];
    
    // Then create and add our custom BBBadgeBarButtonItem
    BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
    // Set a value for the badge
    barButton.badgeValue = @"5";
    barButton.badgeOriginX = 13;
    barButton.badgeOriginY = -9;
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)inviteNewMeeting {
    ListInvitationViewController *listInvitationViewController = [[ListInvitationViewController alloc] initWithNibName:@"ListInvitationViewController" bundle:nil];
    [self.navigationController presentViewController:listInvitationViewController animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
