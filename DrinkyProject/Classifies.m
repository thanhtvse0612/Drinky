//
//  Classifies.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/28/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "Classifies.h"

@implementation Classifies
@synthesize storeClassifiesId, storeClassifiesName;

-(instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.storeClassifiesName = [decoder decodeObjectForKey:@"storeClassifiesName"];
        self.storeClassifiesId = [decoder decodeObjectForKey:@"storeClassifiesId"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:storeClassifiesName forKey:@"storeClassifiesName"];
    [encoder encodeObject:storeClassifiesId forKey:@"storeClassifiesId"];
}
@end
