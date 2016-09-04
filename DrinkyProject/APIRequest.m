//
//  APIRequest.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "APIRequest.h"
#import "Define.h"
#import "APIDefine.h"

static APIRequest *shareInstance;

@implementation APIRequest
#pragma mark - Singleton
+ (instancetype) shareInstance {
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        if (shareInstance == nil) {
            shareInstance = [[APIRequest alloc] init];
        }
    });
    return shareInstance;
}

#pragma mark - Private method
#pragma mark - doRegister
- (void) callAPIRegisterWithFullname:(NSString *)fullname Password:(NSString *)password Phone:(NSString *)phone Authen:(NSString *)authMethod DeviceId:(NSString *)deviceId Email:(NSString *)email andCompletion:(completion)completion {
        NSDictionary *params = @{kParam_Fullname: fullname, kParam_DeviceId: deviceId, KParam_Authen:authMethod, kParam_Password: password, kParam_PhoneNumber: phone, kParam_Email: email};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_RegisterAccount,[self urlEncodedStringWithDictionary:params]];

    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, nil);
        } else {
            completion (nil, error);
        }
    }];
}
#pragma mark - doLogin
- (void) callAPILoginWithPhone:(NSString *)phone Password:(NSString *)password DeviceId:(NSString *)deviceId AuthMethod:(NSString *)authMethod andCompletion:(completion)completion {
    NSDictionary *params = @{kParam_DeviceId: deviceId, KParam_Authen:@"asd", kParam_Password: password, kParam_PhoneNumber: phone};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_Login, [self urlEncodedStringWithDictionary:params]];
    
    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - getFriendList
- (void) callAPIGetFriendListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion {
    NSString *accessTokenEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)accessToken,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                        kCFStringEncodingUTF8));
    NSDictionary *params = @{kParam_AccessToken: accessTokenEncode};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_FriendList, [self urlEncodedStringWithDictionary:params]];
     [self callAPIWithMethod:GET andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - getStoreList
- (void) callAPIGetStoreListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion {
    NSString *accessTokenEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                               NULL,
                                                                               (CFStringRef)accessToken,
                                                                               NULL, 
                                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", 
                                                                               kCFStringEncodingUTF8));
    NSDictionary *params = @{kParam_AccessToken: accessTokenEncode};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_StoreList, [self urlEncodedStringWithDictionary:params]];
    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - doCreateMetting
- (void) callAPICreateMeetingWithTopic:(NSString *)topic
                                  desc:(NSString*)desc
                                  date:(NSString *)date
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                             friendIds:(NSString *)friendIds
                               storeId:(NSNumber *)storeId
                            accessToken:(NSString *)accessToken
                         andCompletion:(completion)completion {
    NSString *startTimeEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)startTime,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                        kCFStringEncodingUTF8));
    NSString *endTimeEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)endTime,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                        kCFStringEncodingUTF8));
    NSString *accessTokenEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)accessToken,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                    kCFStringEncodingUTF8));
    NSDictionary *params = @{kParam_Topic: topic, kParam_Desc:desc, kParam_Date: date, kParam_StartTime: startTimeEncode, kParam_EndTime: endTimeEncode, kParam_FriendIds: friendIds, kParam_StoreId:storeId, kUserDefault_AccessToken:accessTokenEncode};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_CreateMeetting, [self urlEncodedStringWithDictionary:params]];

    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - doUpdateUserInformation
- (void) callAPIUpdateProfileWithPhoneNumber:(NSString *)phoneNumber
                                    fullName:(NSString*)fullName
                                         hId:(NSString *)hId
                                     address:(NSString *)address
                                    birthday:(NSString *)birthday
                                      gender:(NSString *)gender
                                     country:(NSString *)country
                                        city:(NSString *)city
                                 accessToken:(NSString *)accessToken
                               andCompletion:(completion)completion {
    NSString *accessTokenEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)accessToken,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                        kCFStringEncodingUTF8));
    NSString *fullnameEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)fullName,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                     kCFStringEncodingUTF8));
    NSString *addressEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)address,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                     kCFStringEncodingUTF8));
    NSString *countryEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)country,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                     kCFStringEncodingUTF8));
    NSString *cityEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)city,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                    kCFStringEncodingUTF8));

    NSDictionary *params = @{kParam_PhoneNumber: phoneNumber, kParam_Fullname:fullnameEncode, kParam_Address: addressEncode, kParam_Birthday: birthday, kParam_Gender: gender, kParam_Country: countryEncode, kParam_City:cityEncode, kParam_AccessToken:accessTokenEncode, kParam_HID: hId};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_UpdateProfile, [self urlEncodedStringWithDictionary:params]];
    
    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - doReauthorized
- (void) callAPIReauthorizeWithAccessToken:(NSString *)accessToken
                               andCompletion:(completion)completion {
    NSString *accessTokenEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)accessToken,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                        kCFStringEncodingUTF8));
    NSDictionary *params = @{kParam_AccessToken:accessTokenEncode};
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",URL_Server,API_URL_Reauthorized,[self urlEncodedStringWithDictionary:params]];
    
    [self callAPIWithMethod:POST andURL:urlString andCompletion:^(NSDictionary *jsonDictionary, NSError *error) {
        if (!error) {
            completion (jsonDictionary, error);
        } else {
            completion (nil, error);
        }
    }];
}

#pragma mark - Generic method
- (void) callAPIWithURL:(NSString *)urlString method:(methods)method andParams:(NSData *)jsonData andCompletion:(completion)completion{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type"       : @"application/json"};
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //set method
    request.HTTPMethod = [self methodTypeToString:method];
    //set body json data
    request.HTTPBody = jsonData;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            completion(responseObject, nil);
        } else {
            completion(nil, error);
        }
    }];
    [dataTask resume];
}

- (completion) callAPIWithMethod:(methods) method andURL:(NSString *)urlString andCompletion:(void(^)(NSDictionary *jsonDictionary, NSError *error ))completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    switch (method) {
        case GET: {
             [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                completionBlock(responseObject, nil);
            } failure:^(NSURLSessionDataTask *task, NSError * error) {
                completionBlock(nil, error);
            }];
           
            break;
        }
        case POST: {
            [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                completionBlock(responseObject, nil);
            } failure:^(NSURLSessionDataTask *task, NSError * error) {
                completionBlock(nil, error);
            }];
        }
        default:
            break;
    }
    return completionBlock;
}

#pragma mark - encode URL 
-(NSString*) urlEncodedStringWithDictionary:(NSDictionary *)dictionary {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dictionary) {
        id value = [dictionary objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", key, value];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

#pragma mark - Public Method
+ (void) callAPIRegisterWithFullname:(NSString *)fullname Password:(NSString *)password Phone:(NSString *)phone Authen:(NSString *)authMethod DeviceId:(NSString *)deviceId Email:(NSString *)email andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPIRegisterWithFullname:fullname Password:password Phone:phone Authen:authMethod DeviceId:deviceId Email:email andCompletion:completion];
}

+ (void) callAPILoginWithPhone:(NSString *)phone Password:(NSString *)password DeviceId:(NSString *)deviceId AuthMethod:(NSString *)authMethod andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPILoginWithPhone:phone Password:password DeviceId:deviceId AuthMethod:authMethod andCompletion:completion];
}

+ (void) callAPIGetFriendListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPIGetFriendListWithAccessToken:accessToken andCompletion:completion];
}

+ (void) callAPIGetStoreListWithAccessToken:(NSString *)accessToken andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPIGetStoreListWithAccessToken:accessToken andCompletion:completion];
}

+ (void) callAPICreateMeetingWithTopic:(NSString *)topic
                          desc:(NSString*)desc
                          date:(NSString *)date
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                     friendIds:(NSString *)friendIds
                       storeId:(NSNumber *)storeId
                   accessToken:(NSString *)accessToken
                 andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPICreateMeetingWithTopic:topic desc:desc date:date startTime:startTime endTime:endTime friendIds:friendIds storeId:storeId accessToken:accessToken andCompletion:completion];
}

+ (void) callAPIUpdateProfileWithPhoneNumber:(NSString *)phoneNumber
                                    fullName:(NSString*)fullName
                                         hId:(NSString *)hId
                                     address:(NSString *)address
                                    birthday:(NSString *)birthday
                                      gender:(NSString *)gender
                                     country:(NSString *)country
                                        city:(NSString *)city
                                 accessToken:(NSString *)accessToken
                               andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPIUpdateProfileWithPhoneNumber:phoneNumber fullName:fullName hId:hId address:address birthday:birthday gender:gender country:country city:city accessToken:accessToken andCompletion:completion];
}

+ (void) callAPIReauthorizeWithAccessToken:(NSString *)accessToken
                             andCompletion:(completion)completion {
    [[APIRequest shareInstance] callAPIReauthorizeWithAccessToken:accessToken andCompletion:completion];
}

- (NSString*)methodTypeToString:(methods)methodType {
    NSString *result = nil;
    
    switch(methodType) {
        case GET:
            result = @"GET";
            break;
        case POST:
            result = @"POST";
            break;
        default:
            break;
    }
    return result;
}

@end
