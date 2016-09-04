//
//  Friend.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject <NSCoding>
@property (strong, nonatomic) NSString *friendUserId;
@property (strong, nonatomic) NSString *friendDisplayName;
@property (strong, nonatomic) NSString *friendAvatarLinkImage;
@property (strong, nonatomic) NSString *friendPhoneNumber;
@property (strong, nonatomic) NSNumber *friendStatus;
//statusChosen: checked is chosen or not in friend list 
@property (nonatomic, readwrite, getter=isChosen) BOOL statusChosen;
@end
