//
//  Criteria.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "Criteria.h"

@implementation Criteria
@synthesize storeCriteriaName, storeCriteriaScore;

-(instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeCriteriaScore = [decoder decodeObjectForKey:@"storeCriteriaScore"];
        self.storeCriteriaName = [decoder decodeObjectForKey:@"storeCriteriaName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeCriteriaScore forKey:@"storeCriteriaScore"];
    [encoder encodeObject:storeCriteriaName forKey:@"storeCriteriaName"];
}
@end
