//
//  ScoreDetailList.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "StoreDetailList.h"

@implementation StoreDetailList
@synthesize storeStoreDetailListCostCriteria, storeStoreDetailListQualityCriteria,storeStoreDetailListServiceCriteria, storeStoreDetailListDecorateCriteria, storeStoreDetailListLocationCriteria;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeStoreDetailListDecorateCriteria = [decoder decodeObjectForKey:@"storeStoreDetailListDecorateCriteria"];
        self.storeStoreDetailListServiceCriteria = [decoder decodeObjectForKey:@"storeStoreDetailListServiceCriteria"];
        self.storeStoreDetailListLocationCriteria = [decoder decodeObjectForKey:@"storeStoreDetailListLocationCriteria"];
        self.storeStoreDetailListQualityCriteria = [decoder decodeObjectForKey:@"storeStoreDetailListQualityCriteria"];
        self.storeStoreDetailListCostCriteria = [decoder decodeObjectForKey:@"storeStoreDetailListCostCriteria"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeStoreDetailListDecorateCriteria forKey:@"storeStoreDetailListDecorateCriteria"];
    [encoder encodeObject:storeStoreDetailListServiceCriteria forKey:@"storeStoreDetailListServiceCriteria"];
    [encoder encodeObject:storeStoreDetailListLocationCriteria forKey:@"storeStoreDetailListLocationCriteria"];
    [encoder encodeObject:storeStoreDetailListQualityCriteria forKey:@"storeStoreDetailListQualityCriteria"];
    [encoder encodeObject:storeStoreDetailListCostCriteria forKey:@"storeStoreDetailListCostCriteria"];
}
@end
