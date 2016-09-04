//
//  DBManager.h
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/14/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Store.h"
#import "Friend.h"
@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

+ (instancetype) shareInstance;
//Store query
- (NSMutableArray *)getListStore;
- (NSMutableArray *)getListStoreName;
- (Store *)getStoreByStoreId:(NSNumber *)storeId;
- (void)saveListStoreWithData:(Store *)store;
//Friend query
- (NSMutableArray *)getListFriend;
- (NSMutableArray *)getlIstFriendName;
- (void)saveListFriendWithData:(NSArray *)friendList andFriendRecentInvite:(NSNumber *)friendRecentInvite;
- (NSMutableArray *)getListFriendRecentInvite;

@end
