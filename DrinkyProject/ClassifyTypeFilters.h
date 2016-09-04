//
//  ClassifyTypeFilters.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Classifies.h"

@interface ClassifyTypeFilters : NSObject <NSCoding>
@property (strong, nonatomic) NSString *storeClassifyTypeFilterId;
@property (strong, nonatomic) NSString *storeClassifyTypeFilterName;
@property (strong, nonatomic) NSArray *storeClassifyTypeFilterClassifies;

@end
