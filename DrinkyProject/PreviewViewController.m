//
//  PreViewViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "PreviewViewController.h"
#import "Define.h"
#import "FriendRequestViewController.h"
#import "AppDelegate.h"
#import "LGSemiModalNavViewController.h"
#import "ConfirmViewController.h"
#import "AppDelegate.h"
#import "Utilities.h"


@interface PreviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbStoreName;


@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = self.view.bounds;
    [self doLayoutScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveToConfirm:(id)sender {
    [self buttonWasPressed];
    [userdefault setBool:YES forKey:kUserDefault_isInvite];
}

- (void)doLayoutScreen {
    _lbStoreName.text = _aStore.storeName;
}


-(void)buttonWasPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(initConfirmView) withObject:nil afterDelay:0.5];
}

- (void)initConfirmView {
    ConfirmViewController *lgVC = [[ConfirmViewController alloc]initWithFormat:LGViewControllerFormatGoBack];
    LGSemiModalNavViewController *semiModal = [[LGSemiModalNavViewController alloc]initWithRootViewController:lgVC];
    semiModal.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500);
    semiModal.backgroundShadeColor = [UIColor blackColor];
    semiModal.animationSpeed = 0.35f;
    semiModal.tapDismissEnabled = YES;
    semiModal.backgroundShadeAlpha = 0.4;
    semiModal.scaleTransform = CGAffineTransformMakeScale(.94, .94);

    //set param
    lgVC.startInviteObj.store = _aStore;
    lgVC.btnWhere.backgroundColor = [UIColor redColor];
    [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(lgVC.startInviteObj.statusObj.intValue + 1)];
    [myAppdelegate startInviteObj].store = _aStore;
    [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
    [[myAppdelegate whereNavigationController] presentViewController:semiModal animated:YES completion:nil];

}

- (IBAction)moveViewToDetail:(id)sender {
}
@end
