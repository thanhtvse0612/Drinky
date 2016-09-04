//
//  LoginViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueButton.h"
#import "BaseViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnFacebookLogin;

@end
