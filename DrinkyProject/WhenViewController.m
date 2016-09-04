//
//  WhenViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/19/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "WhenViewController.h"
#import "Define.h"
#import "ConfirmViewController.h"
#import "Utilities.h"
#import "AppDelegate.h"

@interface WhenViewController ()

@end

@implementation WhenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarButon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)addBarButon {
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(chooseFriendForInvitation)];
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)chooseFriendForInvitation {
    ConfirmViewController *confirmViewController = [[self.navigationController viewControllers] firstObject];
    [myAppdelegate startInviteObj].timeInvitation = [_dateTimePicker date];
    [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(confirmViewController.startInviteObj.statusObj.intValue + 1)];
    [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
