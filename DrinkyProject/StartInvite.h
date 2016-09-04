//
//  StartInvite.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/30/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"

@interface StartInvite : NSObject <NSCoding>
@property (strong, nonatomic) Store *store;
@property (strong, nonatomic) NSArray *friendArray;
@property (strong, nonatomic) NSDate *timeInvitation;
@property (strong, nonatomic) NSString *reason;
// statusObj: if = 4 -> checked all information
@property (strong, nonatomic) NSNumber *statusObj;
@end
