//
//  AcceptButton.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "AcceptButton.h"
#import "Utilities.h"

@implementation AcceptButton
-(void)awakeFromNib {
    [self setBackgroundColor:[UIColor orangeColor]];
    [self.layer setCornerRadius:5.f];
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
