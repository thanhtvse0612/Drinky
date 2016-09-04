//
//  StartInviteViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "StartInviteViewController.h"
#import "LocalizableDefine.h"
#import "Define.h"
#import "AppDelegate.h"
#import "ConfirmViewController.h"
#import "LGSemiModalNavViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "StartInvite.h"
#import "LuckyRotateGamesViewController.h"

@interface StartInviteViewController () {
}
@property (weak, nonatomic) IBOutlet BlueButton *btnStartInvite;

@end

@implementation StartInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(StartInviteScreen, nil)];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)tapStartInvite:(id)sender {
    [self buttonWasPressed];
    [userdefault setBool:YES forKey:kUserDefault_isInvite];
}

-(void)buttonWasPressed{
    CGRect screen = [[UIScreen mainScreen] bounds];
    ConfirmViewController *lgVC = [[ConfirmViewController alloc]initWithFormat:LGViewControllerFormatGoBack];
    LGSemiModalNavViewController *semiModal = [[LGSemiModalNavViewController alloc]initWithRootViewController:lgVC];
    semiModal.view.frame = CGRectMake(0, 0, screen.size.width, screen.size.height - 70);
    semiModal.backgroundShadeColor = [UIColor blackColor];
    semiModal.animationSpeed = 0.35f;
    semiModal.tapDismissEnabled = YES;
    semiModal.backgroundShadeAlpha = 0.4;
    semiModal.scaleTransform = CGAffineTransformMakeScale(.94, .94);
    [self presentViewController:semiModal animated:YES completion:nil];
}

- (IBAction)buttonGames:(id)sender {
    LuckyRotateGamesViewController *luckyRotateGamesViewController = [[LuckyRotateGamesViewController alloc] initWithNibName:@"LuckyRotateGamesViewController" bundle:nil];
    [self.navigationController pushViewController:luckyRotateGamesViewController animated:YES];
}


@end
