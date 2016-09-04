//
//  ChangePasswordViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/7/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <AFMInfoBanner.h>

@interface ChangePasswordViewController () {
    BOOL isValid;
    NSString *errorMessage;
}
@property (weak, nonatomic) IBOutlet UITextField *tfOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmOldPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet BlueButton *btnUpdate;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Change Password"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Validation
- (BOOL)checkInput {
    isValid = TRUE;
    if (_tfConfirmOldPassword.text != _tfNewPassword.text) {
        isValid = FALSE;
        errorMessage = @"Confirm Password is not match with New Password";
    }
    if (_tfConfirmOldPassword.text.length == 0) {
        isValid = FALSE;
        errorMessage = @"Please Confirm New Password";
    }
    if (_tfNewPassword.text.length == 0 ) {
        isValid = FALSE;
        errorMessage = @"Please Input New Password";
    }
    if (_tfOldPassword.text.length == 0) {
        isValid = FALSE;
        errorMessage = @"Please Input Old Password";
    }
    return isValid;
}

#pragma mark - UITextField Validation
- (IBAction)tapUpdatePassword:(id)sender {
    BOOL check = [self checkInput];
    if (!check) {
        [AFMInfoBanner showWithText:errorMessage style:AFMInfoBannerStyleError andHideAfter:3];
    }
    
}


@end
