//
//  Store.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/18/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "Store.h"

@implementation Store
@synthesize  storeClassifyTypeFilter, storeInstagramUrl, storeDefaultExchange, storeFeatureImage, storeRatingScore, storeFacebookUrl, storeDescription, storeTwitterUrl, storeIsFavorite, storeLongitude, storeGoogleUrl, storeDayInWeek, storeCloseTime, storeOpenTime, storeLatitude, storeDistance, storeAvgPrice, storePhone, storeAddress, storeName, storeId, storeScoreDetailList;
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeId = [decoder decodeObjectForKey:@"storeId"];
        self.storePhone = [decoder decodeObjectForKey:@"storePhone"];
        self.storeAddress = [decoder decodeObjectForKey:@"storeAddress"];
        self.storeName = [decoder decodeObjectForKey:@"storeName"];
        self.storeLatitude = [decoder decodeObjectForKey:@"storeLatitude"];
        self.storeLongitude = [decoder decodeObjectForKey:@"storeLongitude"];
        self.storeFeatureImage = [decoder decodeObjectForKey:@"storeFeatureImage"];
        self.storeDescription = [decoder decodeObjectForKey:@"storeDescription"];
        self.storeTwitterUrl = [decoder decodeObjectForKey:@"storeTwitterUrl"];
        self.storeFacebookUrl = [decoder decodeObjectForKey:@"storeFacebookUrl"];
        self.storeGoogleUrl = [decoder decodeObjectForKey:@"storeGoogleUrl"];
        self.storeInstagramUrl = [decoder decodeObjectForKey:@""];
        self.storeOpenTime = [decoder decodeObjectForKey:@"storeOpenTime"];
        self.storeCloseTime = [decoder decodeObjectForKey:@"storeCloseTime"];
        self.storeDayInWeek = [decoder decodeObjectForKey:@"storeDayInWeek"];
        self.storeAvgPrice = [decoder decodeObjectForKey:@"storeRatingScore"];
        self.storeRatingScore = [decoder decodeObjectForKey:@"storeRatingScore"];
        self.storeDefaultExchange = [decoder decodeObjectForKey:@"storeDefaultExchange"];
        self.storeDistance = [decoder decodeObjectForKey:@"storeDistance"];
        self.storeIsFavorite = [decoder decodeObjectForKey:@"storeIsFavorite"];
        self.storeScoreDetailList = [decoder decodeObjectForKey:@"storeScoreDetailList"];
        self.storeClassifyTypeFilter = [decoder decodeObjectForKey:@"storeClassifyTypeFilter"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeName forKey:@"storeName"];
    [encoder encodeObject:storeId forKey:@"storeId"];
    [encoder encodeObject:storePhone forKey:@"storePhone"];
    [encoder encodeObject:storeAddress forKey:@"storeAddress"];
    [encoder encodeObject:storeLatitude forKey:@"storeLatitude"];
    [encoder encodeObject:storeLongitude forKey:@"storeLongitude"];
    [encoder encodeObject:storeFeatureImage forKey:@"storeFeatureImage"];
    [encoder encodeObject:storeDescription forKey:@"storeDescription"];
    [encoder encodeObject:storeTwitterUrl forKey:@"storeTwitterUrl"];
    [encoder encodeObject:storeFacebookUrl forKey:@"storeFacebookUrl"];
    [encoder encodeObject:storeGoogleUrl forKey:@"storeGoogleUrl"];
    [encoder encodeObject:storeInstagramUrl forKey:@"storeInstagramUrl"];
    [encoder encodeObject:storeOpenTime forKey:@"storeOpenTime"];
    [encoder encodeObject:storeCloseTime forKey:@"storeCloseTime"];
    [encoder encodeObject:storeDayInWeek forKey:@"storeDayInWeek"];
    [encoder encodeObject:storeAvgPrice forKey:@"storeAvgPrice"];
    [encoder encodeObject:storeRatingScore forKey:@"storeRatingScore"];
    [encoder encodeObject:storeDefaultExchange forKey:@"storeDefaultExchange"];
    [encoder encodeObject:storeDistance forKey:@"storeDistance"];
    [encoder encodeObject:storeIsFavorite forKey:@"storeIsFavorite"];
    [encoder encodeObject:storeScoreDetailList forKey:@"storeScoreDetailList"];
    [encoder encodeObject:storeClassifyTypeFilter forKey:@"storeClassifyTypeFilter"];
    
}
@end
