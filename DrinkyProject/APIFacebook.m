//
//  APIFacebook.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/21/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "APIFacebook.h"
static APIFacebook *shareInstance;
@interface APIFacebook ()
@property (strong, nonatomic) FBSDKLoginManager *loginManager;
@end

@implementation APIFacebook

#pragma mark - singleton
+ (instancetype) shareInstance {
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        if (shareInstance == nil) {
            shareInstance = [[APIFacebook alloc] init];
            shareInstance.loginManager = [[FBSDKLoginManager alloc] init];
        }
    });
    return shareInstance;
}

#pragma mark - private method
- (void)initWithReadPermissions:(NSArray *)readPermissions publishPermissions:(NSArray *)publishPermissions {
    self.readPermissions = readPermissions;
    self.publishPermissions = publishPermissions;
}

- (BOOL)isSessionValid
{
    return [FBSDKAccessToken currentAccessToken] != nil;
}

- (void)logoutCallBack:(APIFacebookCallback)callBack
{
    [self.loginManager logOut];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* facebookCookies = [cookies cookiesForURL:[NSURL URLWithString:@"https://facebook.com/"]];
    
    for (NSHTTPCookie* cookie in facebookCookies) {
        [cookies deleteCookie:cookie];
    }
    
    callBack(YES, @"Logout successfully");
}

- (void)loginWithBehavior:(FBSDKLoginBehavior)behavior fromViewController:(UIViewController *)viewController CallBack:(APIFacebookCallback)callBack {
    if (behavior) {
        self.loginManager.loginBehavior = behavior;
    }
    [self.loginManager logInWithReadPermissions:self.readPermissions
                                 fromViewController:viewController
                                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                                if (error) {
                                                    callBack(NO, error.localizedDescription);
                                                } else if (result.isCancelled) {
                                                    NSLog(@"Cancel");
                                                } else {
                                                    if(callBack){
                                                        callBack(!error, result);
                                                    }
                                                }
                                            }];
    
}

- (void)getUserFields:(NSString *)fields callBack:(APIFacebookCallback)callBack
{
    if (![self isSessionValid]) {
        callBack(NO, @"Not logged in");
        return;
    }
    
    [self graphFacebookForMethodGET:@"me" params:@{@"fields" : fields} callBack:callBack];
}


// Generic method API
- (void)graphFacebookForMethodPOST:(NSString *)method params:(id)params callBack:(APIFacebookCallback)callBack
{
    [self graphFacebookForMethod:method httpMethod:@"POST" params:params callBack:callBack];
}

- (void)graphFacebookForMethodGET:(NSString *)method params:(id)params callBack:(APIFacebookCallback)callBack
{
    [self graphFacebookForMethod:method httpMethod:@"GET" params:params callBack:callBack];
}

- (void)graphFacebookForMethod:(NSString *)method httpMethod:(NSString *)httpMethod params:(id)params callBack:(APIFacebookCallback)callBack
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:method
                                       parameters:params
                                       HTTPMethod:httpMethod]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if ([error.userInfo[FBSDKGraphRequestErrorGraphErrorCode] isEqual:@200]) {
             callBack(NO, error);
         } else {
             callBack(YES, result);
         }
     }];
}

#pragma mark - public method 
+ (void)initWithReadPermissions:(NSArray *)readPermissions publishPermissions:(NSArray *)publishPermissions
{
    [[APIFacebook shareInstance] initWithReadPermissions:readPermissions publishPermissions:publishPermissions];
}

+(BOOL)isSessionValid
{
    return [[APIFacebook shareInstance] isSessionValid];
}

+ (void)loginBehavior:(FBSDKLoginBehavior)behavior fromViewController:(UIViewController *)viewController CallBack:(APIFacebookCallback)callBack
{
    [[APIFacebook shareInstance] loginWithBehavior:behavior fromViewController:viewController CallBack:callBack];
}

+ (void)logoutCallBack:(APIFacebookCallback)callBack
{
    [[APIFacebook shareInstance] logoutCallBack:callBack];
}

+ (void)getUserFields:(NSString *)fields callBack:(APIFacebookCallback)callBack
{
    [[APIFacebook shareInstance] getUserFields:fields callBack:callBack];
}
@end
