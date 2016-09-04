//
//  Friend.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize friendUserId, friendStatus,friendDisplayName, friendPhoneNumber, friendAvatarLinkImage, statusChosen;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.friendUserId = [decoder decodeObjectForKey:@"friendUserId"];
        self.friendPhoneNumber = [decoder decodeObjectForKey:@"friendPhoneNumber"];
        self.friendAvatarLinkImage = [decoder decodeObjectForKey:@"friendAvatarLinkImage"];
        self.friendDisplayName = [decoder decodeObjectForKey:@"friendDisplayName"];
        self.statusChosen = [decoder decodeBoolForKey:@"statusChosen"];
        self.friendStatus = [decoder decodeObjectForKey:@"friendStatus"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:friendUserId forKey:@"friendUserId"];
    [encoder encodeObject:friendPhoneNumber forKey:@"friendPhoneNumber"];
    [encoder encodeObject:friendAvatarLinkImage forKey:@"friendAvatarLinkImage"];
    [encoder encodeObject:friendDisplayName forKey:@"friendDisplayName"];
    [encoder encodeObject:friendStatus forKey:@"friendStatus"];
    [encoder encodeBool:statusChosen forKey:@"statusChosen"];
}
@end
