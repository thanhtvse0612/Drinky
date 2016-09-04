//
//  CircleButton.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/19/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CircleButton.h"
#import "Utilities.h"

@implementation CircleButton

-(void)awakeFromNib { 
    [self setImage:[UIImage imageNamed:@"avt_1"] forState:UIControlStateNormal];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.borderColor=[UIColor redColor].CGColor;
    self.layer.borderWidth=2.0f;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted == YES) {
//        self.titleLabel.textColor = [UIColor whiteColor];
//        [self.circleLayer setFillColor:self.color.CGColor];
         [self setImage:[UIImage imageNamed:@"avt_1"] forState:UIControlStateNormal];
    } else {
         [self setImage:[UIImage imageNamed:@"avt_1"] forState:UIControlStateNormal];
    }
}


@end
