//
//  LuckyRotateGamesViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 1/8/16.
//  Copyright © 2016 ThanhTV. All rights reserved.
//

#import "LuckyRotateGamesViewController.h"

@interface LuckyRotateGamesViewController () <JCWheelViewDelegate>

@property (nonatomic, strong) UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberText;
@property (nonatomic, copy) NSArray *numberText;
@end

@implementation LuckyRotateGamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.numberText = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    
    self.luckyWheel.delegate = self;

    self.lbNumberText.text = self.numberText.firstObject;
    
    
}

- (IBAction)tapButtonRotateLuckyWheel:(id)sender {
    [self handleRotateLuckyWheel];
}

- (void)handleRotateLuckyWheel {
    int randomNumber = (arc4random() % 100)*100;
    CGFloat degrees = DEGREES_TO_RADIANS(randomNumber%360);
    NSInteger selectedIndex;
    if (randomNumber%30 == 0) {
        selectedIndex = (randomNumber%360)/30;
    } else {
        selectedIndex = (randomNumber%360)/30+1;
    }
    NSLog(@"number selected: %ld", (long)selectedIndex);
    [UIView animateWithDuration:80.0 animations:^{
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 8 + degrees ];
        rotationAnimation.duration = 8.0;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = NO;
        [self.luckyWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    } completion:^(BOOL finished) {
        NSLog(@"finish");
        self.luckyWheel.transform = CGAffineTransformRotate( self.luckyWheel.transform,degrees);
        
        [self performSelector:@selector(showAlert) withObject:nil afterDelay:8.0];
        if ([self.luckyWheel.delegate respondsToSelector:@selector(wheelView:didSelectItemAtIndex:)]) {
            [self.luckyWheel.delegate wheelView: self.luckyWheel didSelectItemAtIndex:selectedIndex];
        }
    }];
}

-(void)showAlert {
    [[Utilities shareInstance] showAlertViewControllerLuckyWheelWithTitle:@"Lucky Wheel"
                                                                  message:@"Congratulation!!!!"
                                                           styleAlertView:LEAlertControllerStyleAlert
                                                             cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                           viewController:[[[myAppdelegate startInviteNavigationController] viewControllers] lastObject]
                                                           viewLuckyWheel:self.luckyWheel];
}

#pragma mark - JCWheelViewDelegate

- (NSInteger)numberOfItemsInWheelView:(JCWheelView *)wheelView
{
    return 12;
}

- (void)wheelView:(JCWheelView *)wheelView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"number: %@", self.numberText[index]);
    self.lbNumberText = self.numberText[index];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
