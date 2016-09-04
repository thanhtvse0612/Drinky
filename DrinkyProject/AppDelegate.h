//
//  AppDelegate.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "StartInvite.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *windowBanner;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) UINavigationController *whereNavigationController;
@property (strong, nonatomic) UINavigationController *notificationNavigationController;
@property (strong, nonatomic) UINavigationController *startInviteNavigationController;
@property (strong, nonatomic) UINavigationController *friendNavigationController;
@property (strong, nonatomic) UINavigationController *profileNavigationController;
@property (strong, nonatomic) StartInvite *startInviteObj;
- (void)initTabBarViewController;
@end

