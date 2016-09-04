//
//  Invitation.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/23/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invitation : NSObject
@property (strong, nonatomic) NSNumber *invitationId;
@property (strong, nonatomic) NSString *invitationDate;
@property (strong, nonatomic) NSString *invitationTitle;
@property (strong, nonatomic) NSString *invitationAddress;
@property (strong, nonatomic) NSNumber *invitatioType;
@end
