//
//  WhyViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "WhyViewController.h"
#import "Define.h"
#import "Utilities.h"
#import "ConfirmViewController.h"
#import "Define.h"
#import "AppDelegate.h"

@interface WhyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WhyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.layer.borderWidth = 1.0f;
    _textView.layer.cornerRadius = 10.0f;
    _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
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
    [myAppdelegate startInviteObj].reason = [_textView text];
    [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(confirmViewController.startInviteObj.statusObj.intValue + 1)];
    [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
