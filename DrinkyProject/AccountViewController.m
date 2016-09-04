//
//  ChangePasswordViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/4/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "AccountViewController.h"
#import "ChangePasswordViewController.h"
#import "DeleteAccountViewController.h"
#import "LinkFacebookViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Account"];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self addGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture 
- (void)addGesture {
    UITapGestureRecognizer *tapGestureChangePassword = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToChangeAccountPassword)];
    [_viewChangeAccountPassword addGestureRecognizer:tapGestureChangePassword];
    UITapGestureRecognizer *tapGestureDeleteAccount = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToDeleteAccount)];
    [_viewDeleteAccount addGestureRecognizer:tapGestureDeleteAccount];
    UITapGestureRecognizer *tapGestureLinkFacebook = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToLinkWithFacebook)];
    [_viewLinkFacebook addGestureRecognizer:tapGestureLinkFacebook];

}

- (void)moveToChangeAccountPassword {
    ChangePasswordViewController *changeAccountPasswordViewController = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changeAccountPasswordViewController animated:YES];
}

- (void)moveToDeleteAccount {
    DeleteAccountViewController *deleteAccountViewController = [[DeleteAccountViewController alloc] initWithNibName:@"DeleteAccountViewController" bundle:nil];
    [self.navigationController pushViewController:deleteAccountViewController animated:YES];
    
}

- (void)moveToLinkWithFacebook {
    LinkFacebookViewController *linkFacebookViewController = [[LinkFacebookViewController alloc] initWithNibName:@"LinkFacebookViewController" bundle:nil];
    [self.navigationController pushViewController:linkFacebookViewController animated:YES];
}





@end
