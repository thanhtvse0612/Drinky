//
//  BlueButton.m
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/15/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#import "BlueButton.h"
#import "Utilities.h"

@implementation BlueButton
-(void)awakeFromNib {
    [self setBackgroundColor:[UIColor orangeColor]];
    [self.layer setCornerRadius:10.f];
    [self.layer setBorderWidth:1.f];
    [self.layer setBorderColor:[[[Utilities shareInstance] colorWithHex:0x4F5354] CGColor]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted == YES) {
        [self setBackgroundColor:[[Utilities shareInstance] colorWithHex:0xC1D1DB]];
    } else {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
}

@end
