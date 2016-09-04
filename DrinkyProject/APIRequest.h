//
//  APIRequest.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion) (id responseObject, NSError *error);
typedef enum methods
{
    GET,
    POST
} methods;

@interface APIRequest : NSObject
+ (instancetype) shareInstance;
//doRegister
+ (void) callAPIRegisterWithFullname:(NSString *)fullname Password:(NSString *)password Phone:(NSString *)phone Authen:(NSString *)authMethod DeviceId:(NSString *)deviceId Email:(NSString *)email andCompletion:(completion)comp;
+ (void) callAPILoginWithPhone:(NSString *)phone Password:(NSString *)password DeviceId:(NSString *)deviceId AuthMethod:(NSString *)authMethod andCompletion:(completion)completion;
+ (void) callAPIGetFriendListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion;
+ (void) callAPIGetStoreListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion;
+ (void) callAPICreateMeetingWithTopic:(NSString *)topic
                                  desc:(NSString*)desc
                                  date:(NSString *)date
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                             friendIds:(NSString *)friendIds
                               storeId:(NSNumber *)storeId
                           accessToken:(NSString *)accessToken
                         andCompletion:(completion)completion ;
+ (void) callAPIUpdateProfileWithPhoneNumber:(NSString *)phoneNumber
                                    fullName:(NSString*)fullName
                                         hId:(NSString *)hId
                                     address:(NSString *)address
                                    birthday:(NSString *)birthday
                                      gender:(NSString *)gender
                                     country:(NSString *)country
                                        city:(NSString *)city
                                 accessToken:(NSString *)accessToken
                               andCompletion:(completion)completion;
+ (void) callAPIReauthorizeWithAccessToken:(NSString *)accessToken
                             andCompletion:(completion)completion;
@end
