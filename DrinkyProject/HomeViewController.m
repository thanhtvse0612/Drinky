//
//  HomeViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "HomeViewController.h"
#import "StartInviteViewController.h"
#import "Define.h"
#import "AppDelegate.h"
#import "Utilities.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //set the tab bar title appearance for normal state
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                        NSFontAttributeName:[UIFont systemFontOfSize:9.0f]}
                                             forState:UIControlStateNormal];
    
    //set the tab bar title appearance for selected state
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],
                                                        NSFontAttributeName:[UIFont systemFontOfSize:9.0f]}
                                             forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];

    StartInvite *startInviteObj = [[StartInvite alloc] init];
    [[Utilities shareInstance] archieverObject:startInviteObj];
    [self.tabBarController.tabBar setTranslucent:YES];
    [userdefault setObject:kUserDefault_TypeLogin_Facebook forKey:kUserDefault_TypeLogin];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setTranslucent:YES];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.tabBar.translucent= YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
