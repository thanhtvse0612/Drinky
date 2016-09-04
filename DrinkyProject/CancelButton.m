//
//  CancelButton.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CancelButton.h"
#import "Utilities.h"

@implementation CancelButton

-(void)awakeFromNib {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:5.f];
    [self.layer setBorderWidth:1.f];
    [self.layer setBorderColor:[[[Utilities shareInstance] colorWithHex:0x4F5354] CGColor]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted == YES) {
        [self setBackgroundColor:[[Utilities shareInstance] colorWithHex:0xC1D1DB]];
    } else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
