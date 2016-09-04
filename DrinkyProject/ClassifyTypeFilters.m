//
//  ClassifyTypeFilters.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ClassifyTypeFilters.h"

@implementation ClassifyTypeFilters
@synthesize storeClassifyTypeFilterId, storeClassifyTypeFilterName, storeClassifyTypeFilterClassifies;

-(instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeClassifyTypeFilterClassifies = [decoder decodeObjectForKey:@"storeClassifyTypeFilterClassifies"];
        self.storeClassifyTypeFilterName = [decoder decodeObjectForKey:@"storeClassifyTypeFilterName"];
        self.storeClassifyTypeFilterId = [decoder decodeObjectForKey:@"storeClassifyTypeFilterId"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeClassifyTypeFilterClassifies forKey:@"storeClassifyTypeFilterClassifies"];
    [encoder encodeObject:storeClassifyTypeFilterName forKey:@"storeClassifyTypeFilterName"];
    [encoder encodeObject:storeClassifyTypeFilterId forKey:@"storeClassifyTypeFilterId"];
}
@end
