//
//  ClassifyTypeList.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyTypeList : NSObject <NSCoding>
@property (strong, nonatomic) NSString *storeClassifyTypeListIsFavorite;
@property (strong, nonatomic) NSArray *storeClassifyTypeListClassifyFilter;

@end
