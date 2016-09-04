//
//  DBManager.m
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/14/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#import "DBManager.h"

static DBManager *shareInstance;
@interface DBManager() {
    NSMutableArray *arrayList;
}

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic, strong) FMDatabase *database;

-(void)copyDatabaseIntoDocumentsDirectory;

//-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DBManager

+(instancetype) shareInstance {
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        if (shareInstance == nil) {
            shareInstance = [[DBManager alloc] initWithDatabaseFilename:@"/Drinky"];
        }
    });
    return shareInstance;
}

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        // Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        NSString *databasePath = [self.documentsDirectory stringByAppendingString:dbFilename];
        _database = [FMDatabase databaseWithPath:databasePath];
        // Keep the database filename.
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    NSLog(@"DB Path: %@", destinationPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

#pragma mark - Query Function
#pragma mark - Store Query
- (NSMutableArray *)getListStore {
    [_database open];
    arrayList = [[NSMutableArray alloc] init];
    NSString *query = @"select * from Store";
    FMResultSet *arr = [_database executeQuery:query];
    int i = 0;
    while ([arr next]) {
        Store *store = [[Store alloc] init];
        store.storeId =  [NSNumber numberWithInt:[arr intForColumn: @"storeId"]];
        store.storeName =  [arr stringForColumn: @"storeName"];
        store.storeAddress =  [arr stringForColumn: @"storeAddress"];
        store.storePhone =  [arr stringForColumn: @"storePhone"];
        [arrayList insertObject:store atIndex:i];
        i++;
    }
    
    [_database close];
    return arrayList;
}

- (NSMutableArray *)getListStoreName {
    [_database open];
    arrayList = [[NSMutableArray alloc] init];
    NSString *query = @"select * from Store";
    FMResultSet *arr = [_database executeQuery:query];
    int i = 0;
    while ([arr next]) {
        NSString *storeName=  [arr stringForColumn: @"storeName"];
        [arrayList insertObject:storeName atIndex:i];
        i++;
    }
    
    
    [_database close];
    return arrayList;
}

- (Store *)getStoreByStoreId:(NSNumber *)storeId {
    [_database open];
    Store *store = [[Store alloc] init];
    NSString *query = [NSString stringWithFormat:@"select * from Store where StoreID = %@",storeId];
    FMResultSet *arr = [_database executeQuery:query];
    while ([arr next]) {
        store.storeId =  [NSNumber numberWithInt:[arr intForColumn: @"StoreId"] ];
        store.storeName = [arr stringForColumn:@"storeName"];
        store.storeAddress = [arr stringForColumn:@"storeAddress"];
        store.storePhone = [arr stringForColumn:@"storePhone"];
        store.storeAvgPrice = [NSNumber numberWithInt:[arr intForColumn:@"storeAvgPrice"]];
        store.storeDistance = [NSNumber numberWithInt:[arr intForColumn:@"storeDistance"]];
        store.storeLatitude = [NSNumber numberWithInt:[arr intForColumn:@"storeLatitude"]];
        store.storeOpenTime = [arr stringForColumn:@"storeOpenTime"];
        store.storeCloseTime = [arr stringForColumn:@"storeCloseTime"];
        store.storeDayInWeek = [arr stringForColumn:@"storeDayInWeek"];
        store.storeGoogleUrl = [arr stringForColumn:@"storeGoogleUrl"];
        store.storeLongitude = [NSNumber numberWithInt:[arr intForColumn:@"storeLongitude"]];
        store.storeIsFavorite = [NSNumber numberWithInt:[arr intForColumn:@"storeIsFavorite"]];
        store.storeTwitterUrl = [arr stringForColumn:@"storeTwitterUrl"];
        store.storeDescription = [arr stringForColumn:@"storeDescription"];
        store.storeFacebookUrl = [arr stringForColumn:@"storeFacebookUrl"];
        store.storeRatingScore = [NSNumber numberWithInt:[arr intForColumn:@"storeRatingScore"]];
        store.storeFeatureImage = [arr stringForColumn:@"storeFeatureImage"];
        store.storeDefaultExchange = [NSNumber numberWithInt:[arr intForColumn:@"storeDefaultExchange"]];
        store.storeInstagramUrl = [arr stringForColumn:@"storeInstagramUrl"];
        store.storeScoreDetailList = [arr stringForColumn:@"storeScoreDetailList"];
        store.storeClassifyTypeFilter = [arr stringForColumn:@"storeClassifyTypeFilter"];
    }
    [_database close];
    return store;
}

- (void)saveListStoreWithData:(Store *)store {
    [_database open];
    [_database executeUpdate:@"insert into Store values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", store.storeId, store.storeName, store.storeAddress, store.storePhone, store.storeLatitude, store.storeLongitude, store.storeFeatureImage, store.storeDescription, store.storeTwitterUrl, store.storeFacebookUrl, store.storeGoogleUrl, store.storeInstagramUrl, store.storeOpenTime, store.storeCloseTime, store.storeDayInWeek, store.storeAvgPrice, store.storeRatingScore, store.storeDefaultExchange, store.storeDistance, store.storeIsFavorite, store.storeScoreDetailList, store.storeClassifyTypeFilter];
    [_database close];
}

#pragma mark - Friend Query
- (NSMutableArray *)getListFriend {
    [_database open];
    arrayList = [[NSMutableArray alloc] init];
    NSString *query = @"select * from Friend";
    FMResultSet *arr = [_database executeQuery:query];
    int i = 0;
    while ([arr next]) {
        Friend *friend = [[Friend alloc] init];
        friend.friendUserId =  [arr stringForColumn:@"FriendUserId"];
        friend.friendDisplayName =  [arr stringForColumn: @"FriendDisplayName"];
        friend.friendAvatarLinkImage =  [arr stringForColumn: @"FriendAvatarLinkImage"];
        friend.friendPhoneNumber =  [arr stringForColumn: @"FriendPhoneNumber"];
        friend.friendStatus =  [NSNumber numberWithInt:[arr intForColumn: @"FriendStatus"]];
        [arrayList insertObject:friend atIndex:i];
        i++;
    }
    [_database close];
    return arrayList;
}

- (NSMutableArray *)getlIstFriendName {
    [_database open];
    arrayList = [[NSMutableArray alloc] init];
    NSString *query = @"select * from Friend";
    FMResultSet *arr = [_database executeQuery:query];
    int i = 0;
    while ([arr next]) {
        NSString *storeName=  [arr stringForColumn: @"FriendDisplayName"];
        [arrayList insertObject:storeName atIndex:i];
        i++;
    }
    [_database close];
    return arrayList;
}

- (void)saveListFriendWithData:(NSArray *)friendList andFriendRecentInvite:(NSNumber *)friendRecentInvite {
    [_database open];
    for (int i = 0; i<friendList.count; i++) {
        NSDictionary *friend = [friendList objectAtIndex:i];
        NSString * friendUserId = [friend objectForKey:kResponse_FriendUserId];
        NSString * friendDisplayName = [friend objectForKey:kResponse_FriendDisplayName];
        NSString * friendAvatarLinkImage = [friend objectForKey:kResponse_FriendAvatarLinkImage];
        NSString * friendPhoneNumber = [friend objectForKey:kResponse_FriendPhoneNumber];
        NSNumber * friendStatus = [friend objectForKey:kResponse_FriendStatus];
        NSString *query = [NSString stringWithFormat:@"insert into Friend values ('%@','%@','%@','%@','%@', %@)", friendUserId, friendDisplayName, friendAvatarLinkImage, friendPhoneNumber, friendStatus, friendRecentInvite];
        [_database executeUpdate:query];
    }
    [_database close];
}

- (NSMutableArray *)getListFriendRecentInvite {
    [_database open];
    arrayList = [[NSMutableArray alloc] init];
    NSString *query = @"select * from Friend where friendRecentInvite>3";
    FMResultSet *arr = [_database executeQuery:query];
    int i = 0;
    while ([arr next]) {
        Friend *friend = [[Friend alloc] init];
        friend.friendUserId =  [arr stringForColumn:@"FriendUserId"];
        friend.friendDisplayName =  [arr stringForColumn: @"FriendDisplayName"];
        friend.friendAvatarLinkImage =  [arr stringForColumn: @"FriendAvatarLinkImage"];
        friend.friendPhoneNumber =  [arr stringForColumn: @"FriendPhoneNumber"];
        friend.friendStatus =  [NSNumber numberWithInt:[arr intForColumn: @"FriendStatus"]];
        [arrayList insertObject:friend atIndex:i];
        i++;
    }
    [_database close];
    return arrayList;
}

@end
