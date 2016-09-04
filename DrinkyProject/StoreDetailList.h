//
//  ScoreDetailList.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Criteria.h"

@interface StoreDetailList : NSObject <NSCoding>
@property (nonatomic, strong) NSNumber *storeStoreDetailListDecorateCriteria;
@property (nonatomic, strong) NSNumber *storeStoreDetailListLocationCriteria;
@property (nonatomic, strong) NSNumber *storeStoreDetailListServiceCriteria;
@property (nonatomic, strong) NSNumber *storeStoreDetailListQualityCriteria;
@property (nonatomic, strong) NSNumber *storeStoreDetailListCostCriteria;
@end
