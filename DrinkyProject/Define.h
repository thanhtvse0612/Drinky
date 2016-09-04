//
//  Define.h
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/15/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#ifndef FoodDelivery_Define_h
#define FoodDelivery_Define_h
#endif

//color
#define colorPrimary 0xffa633
#define colorPrimaryDark 0xfa8f04
#define colorPrimaryLight 0xffdbae
#define colorPrimaryExDark 0xa55e02

//Define
#define userdefault [NSUserDefaults standardUserDefaults]
#define myAppdelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define MHVOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define DEGREES_TO_RADIANS(d) ((d) * M_PI / 180)
#define RADIANS_TO_DEGREES(d) ((d) * 180 / M_PI)

//API google key
#define GOOGLE_MAP_API_KEY @"AIzaSyDPe2IqnCF3Liyxy9RBoiaFx8KhcdnFMMQ"

//UserDefault
#define kUserDefault_DeviceId @"DeviceId"
#define kUserDefault_TypeLogin @"TypeLogin"
#define kUserDefault_TypeLogin_Normal @"Normal"
#define kUserDefault_TypeLogin_Facebook @"Facebook"
#define kUserDefault_AvatarName @"AvatarName"
#define kUserDefault_isInvite @"isInvite"
#define kUserDefault_StartInviteObj @"StartInviteObj"
#define kUserDefault_AccessToken @"accessToken"
#define kUserDefault_AvatarImageLink @"avatarImageLink"
#define kUserDefault_DisplayName @"displayName"
#define kUserDefault_Email @"email"
#define kUserDefault_PhoneNumber @"phoneNumber"
#define kUserDefault_UserId @"userId"
#define kUserDefault_Username @"userName"
#define kUserDefault_isLoginBefore @"isLoginBefore"

//date time format
#define TimeFormat @"HH:mm:ss"
#define DateFormat @"dd-MM-yyyy"

//Directory Path
#define  PicturePath @"picture"
#define  PictureAvatar @"picture/avatar"