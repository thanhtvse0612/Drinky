//
//  PreLoginViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "PreLoginViewController.h"
#import "LocalizableDefine.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PreLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet BlueButton *btnLogin;
@property (weak, nonatomic) IBOutlet BlueButton *btnRegister;

@end

@implementation PreLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doLayoutScreen];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)doLayoutScreen {
    [_imgLogo setImage:[UIImage imageNamed:@"ic_drinky"]];
    _btnLogin.layer.cornerRadius = 7.0f;
    _btnLogin.backgroundColor = [UIColor whiteColor];
    [_btnLogin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnLogin setTitle:NSLocalizedString(LoginButtonName, nil) forState:UIControlStateNormal];
    
    _btnRegister.layer.cornerRadius = 7.0f;
    _btnRegister.backgroundColor = [[Utilities shareInstance] colorWithHex:0xff8100];
    [_btnRegister setTitle:NSLocalizedString(RegisterButtonName, nil) forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapLogin:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
}

- (IBAction)tapRegister:(id)sender {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController presentViewController:registerViewController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


@end
