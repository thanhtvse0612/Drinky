//
//  ProfileViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ProfileViewController : BaseViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *btnLogout;

@end
