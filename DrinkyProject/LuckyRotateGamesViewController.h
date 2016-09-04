//
//  LuckyRotateGamesViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 1/8/16.
//  Copyright © 2016 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCWheelView.h"

@interface LuckyRotateGamesViewController : UIViewController
@property (weak, nonatomic) IBOutlet JCWheelView *luckyWheel;
@property (weak, nonatomic) IBOutlet UIButton *btnRotate;



@end
