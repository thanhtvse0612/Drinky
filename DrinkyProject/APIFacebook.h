//
//  APIFacebook.h
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/21/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

typedef void(^APIFacebookCallback)(BOOL success, id result);

@interface APIFacebook : NSObject 

@property (strong, nonatomic) NSArray *readPermissions;
@property (strong, nonatomic) NSArray *publishPermissions;

// API public
+ (instancetype) shareInstance;
+ (void)initWithReadPermissions:(NSArray *)readPermissions publishPermissions:(NSArray *)publishPermissions;
+ (BOOL)isSessionValid;
+ (void)loginBehavior:(FBSDKLoginBehavior)behavior fromViewController:(UIViewController *)viewController CallBack:(APIFacebookCallback)callBack;
+ (void)logoutCallBack:(APIFacebookCallback)callBack;
+ (void)getUserFields:(NSString *)fields callBack:(APIFacebookCallback)callBack;
@end
