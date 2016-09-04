//
//  StartInvite.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "StartInvite.h"

@implementation StartInvite

@synthesize store;
@synthesize reason;
@synthesize friendArray;
@synthesize statusObj;
@synthesize timeInvitation;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.store = [decoder decodeObjectForKey:@"store"];
        self.reason = [decoder decodeObjectForKey:@"reason"];
        self.statusObj = [decoder decodeObjectForKey:@"statusObj"];
        self.friendArray = [decoder decodeObjectForKey:@"friendArray"];
        self.timeInvitation = [decoder decodeObjectForKey:@"timeInvitation"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:store forKey:@"store"];
    [encoder encodeObject:reason forKey:@"reason"];
    [encoder encodeObject:statusObj forKey:@"statusObj"];
    [encoder encodeObject:friendArray forKey:@"friendArray"];
    [encoder encodeObject:timeInvitation forKey:@"timeInvitation"];
}

@end
