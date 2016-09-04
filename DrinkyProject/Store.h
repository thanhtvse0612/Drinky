//
//  Store.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/18/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreDetailList.h"
#import "ClassifyTypeList.h"
@interface Store : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSNumber *storeLatitude;
@property (nonatomic, strong) NSNumber *storeLongitude;
@property (nonatomic, strong) NSString *storeFeatureImage;
@property (nonatomic, strong) NSString *storeDescription;
@property (nonatomic, strong) NSString *storePhone;
@property (nonatomic, strong) NSString *storeTwitterUrl;
@property (nonatomic, strong) NSString *storeFacebookUrl;
@property (nonatomic, strong) NSString *storeGoogleUrl;
@property (nonatomic, strong) NSString *storeInstagramUrl;
@property (nonatomic, strong) NSString *storeOpenTime;
@property (nonatomic, strong) NSString *storeCloseTime;
@property (nonatomic, strong) NSString *storeDayInWeek;
@property (nonatomic, strong) NSNumber *storeAvgPrice;
@property (nonatomic, strong) NSNumber *storeRatingScore;
@property (nonatomic, strong) NSNumber *storeDefaultExchange;
@property (nonatomic, strong) NSNumber *storeDistance;
@property (nonatomic, strong) NSNumber *storeIsFavorite;
@property (nonatomic, strong) NSString *storeScoreDetailList;
@property (nonatomic, strong) NSString *storeClassifyTypeFilter;


@end
