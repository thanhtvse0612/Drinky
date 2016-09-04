//
//  CustomStoreCell.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomStoreCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@end
