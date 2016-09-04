//
//  CustomStoreCell.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "CustomStoreCell.h"

@implementation CustomStoreCell

- (void)awakeFromNib {
    // Initialization code
    _imageView.layer.cornerRadius = 10.0f;
    _imageView.clipsToBounds = YES;
}


@end
