//
//  ClassifyTypeList.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ClassifyTypeList.h"

@implementation ClassifyTypeList
@synthesize storeClassifyTypeListIsFavorite, storeClassifyTypeListClassifyFilter;

-(instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeClassifyTypeListClassifyFilter = [decoder decodeObjectForKey:@"storeClassifyTypeListClassifyFilter"];
        self.storeClassifyTypeListIsFavorite = [decoder decodeObjectForKey:@"storeClassifyTypeListIsFavorite"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeClassifyTypeListClassifyFilter forKey:@"storeClassifyTypeListClassifyFilter"];
    [encoder encodeObject:storeClassifyTypeListIsFavorite forKey:@"storeClassifyTypeListIsFavorite"];
}
@end
