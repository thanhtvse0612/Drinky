//
//  ConfirmViewController.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/26/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartInvite.h"
#import "BlueButton.h"

typedef enum : NSUInteger {
    LGViewControllerFormatTapMe,
    LGViewControllerFormatGoBack,
} LGViewControllerFormat;

@interface ConfirmViewController : UIViewController
-(id)initWithFormat:(LGViewControllerFormat)format;

@property (strong, nonatomic) StartInvite *startInviteObj;
@property (weak, nonatomic) IBOutlet UIButton *btnWhere;
@property (weak, nonatomic) IBOutlet UIButton *btnWho;
@property (weak, nonatomic) IBOutlet UIButton *btnWhen;
@property (weak, nonatomic) IBOutlet UIButton *btnWhy;
@property (weak, nonatomic) IBOutlet UILabel *lbWhere;
@property (weak, nonatomic) IBOutlet UILabel *lbWho;
@property (weak, nonatomic) IBOutlet UILabel *lbWhen;
@property (weak, nonatomic) IBOutlet UILabel *lbWhy;
@property (weak, nonatomic) IBOutlet BlueButton *btnConfirm;
@property (strong, nonatomic) NSMutableArray *friendArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;

@end
