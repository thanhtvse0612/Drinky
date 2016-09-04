//
//  SplashViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "SplashViewController.h"
#import "PreLoginViewController.h"
#import "ActivityIndicatorView.h"

@interface SplashViewController () <ActivityIndicatorViewDelegate>{
    BOOL isReauthorizedSuccess;
    NSTimer *timer;
    int i;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) ActivityIndicatorView *indicatorView;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imgLogo setImage:[UIImage imageNamed:@"ic_drinky"]];
    isReauthorizedSuccess = NO;
    
    //init timer
    i = 0;
    [self initTimer];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    //indicator view
    _indicatorView = [[ActivityIndicatorView alloc] init];
    _indicatorView.delegate = self;
    _indicatorView.numberOfCircles = 5;
    _indicatorView.radius = 5;
    _indicatorView.internalSpacing = 10;
    [_indicatorView startAnimating];
    
    [self.view addSubview:_indicatorView];
    [self placeAtTheCenterWithView:_indicatorView];

    // call API
    if ([userdefault objectForKey:kUserDefault_isLoginBefore]) {
        [self callAPIReauthorized];
    }
}

- (void)placeAtTheCenterWithView:(UIView *)view {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0f
                                                           constant:0.0f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.imgLogo
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.0f
                                                           constant:20.0f]];
}

- (void)initTimer {
    timer = [NSTimer timerWithTimeInterval:0.025f target:self selector:@selector(reauthorizeAccount) userInfo:nil repeats:YES];
}

- (void) reauthorizeAccount {
    if (i<100 && isReauthorizedSuccess == NO) {
        i++;
        NSLog(@"%d", i);
        if (i == 70) {
            timer = [NSTimer timerWithTimeInterval:0.04 target:self selector:@selector(reauthorizeAccount) userInfo:nil repeats:YES];
        }
    } else if (![userdefault boolForKey:kUserDefault_isLoginBefore]) {
        [_indicatorView stopAnimating];
        PreLoginViewController *preLoginViewController = [[PreLoginViewController alloc] initWithNibName:@"PreLoginViewController" bundle:nil];
        [self.navigationController setViewControllers:@[preLoginViewController] animated:YES];
        timer = nil;
        [timer invalidate];
//        [NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelTimer) object:nil];
    }
}

- (void) cancelTimer {
    timer = nil;
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - ActivityIndicatorViewDelegate
- (UIColor *)activityIndicatorView:(ActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - Call API reauthorized
- (void) callAPIReauthorized {
    dispatch_group_t group = dispatch_group_create();
    __block NSString *statusCode;
    __block NSError *err;
    __block NSString *accessTokenResponse;
    NSString *accessToken = [userdefault objectForKey:kUserDefault_AccessToken];
    dispatch_group_enter(group);
    [APIRequest callAPIReauthorizeWithAccessToken:accessToken andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            statusCode = [responseObject objectForKey:kResponse_Status];
            accessTokenResponse = [responseObject objectForKey:kResponse_AccessToken];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([statusCode isEqualToString:API_Status_Code_00]) {
            NSLog(@"Reauthorized Succesfullly");
            isReauthorizedSuccess = YES;
            [userdefault setObject:accessTokenResponse forKey:kUserDefault_AccessToken];
            [myAppdelegate initTabBarViewController];
        } else {
            [[Utilities shareInstance] showAlertViewControllerCanCelWithTitle:@"Title: Disconnect Network"
                                                                                 message:@"Message: Disconnect Network"
                                                                          styleAlertView:LEAlertControllerStyleAlert
                                                                            cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                                          viewController:self];
        }
    });
}


















@end
