//
//  PreviewFriendsViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "PreviewFriendsViewController.h"
#import "ConfirmViewController.h"
#import "LGSemiModalNavViewController.h"
#import "Define.h"
#import "AppDelegate.h"
#import "Utilities.h"

@interface PreviewFriendsViewController ()

@end

@implementation PreviewFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doLayoutScreen];
}

- (void)doLayoutScreen {
    _lbName.text = _aFriend.friendDisplayName;
    _lbAddress.text = @"135 Nam Kì Khởi Nghĩa, Quận 1, Hồ Chí Minh City";
    _lbDescription.text = @"Code như nồi + Đúc nồi siêu hạng";
    _lbPhoneNumber.text = _aFriend.friendPhoneNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveToConfirm:(id)sender {
    [self buttonWasPressed];
    [userdefault setBool:YES forKey:kUserDefault_isInvite];
}

- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - init Confirm View 
-(void)buttonWasPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(initConfirmView) withObject:nil afterDelay:0.5];
}

- (void)initConfirmView {
    //init confirm view with animation
    ConfirmViewController *lgVC = [[ConfirmViewController alloc]initWithFormat:LGViewControllerFormatGoBack];
    LGSemiModalNavViewController *semiModal = [[LGSemiModalNavViewController alloc]initWithRootViewController:lgVC];
    semiModal.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500);
    semiModal.backgroundShadeColor = [UIColor blackColor];
    semiModal.animationSpeed = 0.35f;
    semiModal.tapDismissEnabled = YES;
    semiModal.backgroundShadeAlpha = 0.4;
    semiModal.scaleTransform = CGAffineTransformMakeScale(.94, .94);
    
    //set param
    _aFriend.statusChosen = YES;
    // save selected friend list -> transfer to confirm view
    [lgVC.selectedArray addObject:_aFriend];
    //save startInviteObj to userDefault
    [myAppdelegate startInviteObj].friendArray = lgVC.selectedArray;
    [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:([myAppdelegate startInviteObj].statusObj.intValue + 1)];
    [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
    //move back confirm view
    [[myAppdelegate friendNavigationController] presentViewController:semiModal animated:YES completion:nil];
    
}
@end
