//
//  Criteria.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Criteria : NSObject <NSCoding>
@property (nonatomic, strong) NSString *storeCriteriaName;
@property (nonatomic, strong) NSString *storeCriteriaScore;
@end
