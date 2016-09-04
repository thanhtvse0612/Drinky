//
//  AppDelegate.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "FriendRequestViewController.h"
#import "NotificationViewController.h"
#import "ProfileViewController.h"
#import "BaseViewController.h"
#import "SplashViewController.h"
#import "WhereViewController.h"
#import "StartInviteViewController.h"
#import "ProfileViewController.h"
#import "RegisterViewController.h"
#import "APIFacebook.h"
#import "StoreListViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Get device id
    [self getDeviceId];
    
    // Override point for customization after application launch.
    [self initWindow];
    _startInviteObj = [[StartInvite alloc] init];
    
    // Login init
//    [self initViewController];
//    [self.window setRootViewController:self.navigationController];
    // HomeViewController init
    [self initTabBarViewController];
    
    //status bar orange
    [[UINavigationBar appearance] setBarTintColor:[[Utilities shareInstance] colorWithHex:colorPrimaryDark]];
    //FB Init
    //Init SCFacebook
    [APIFacebook initWithReadPermissions:@[@"user_about_me",
                                          @"user_birthday",
                                          @"email",
                                          @"user_photos",
                                          @"user_events",
                                          @"user_friends",
                                          @"user_videos",
                                          @"public_profile"]
                     publishPermissions:@[@"manage_pages",
                                          @"publish_actions",
                                          @"publish_pages"]
     ];

    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
    // Do the following if you use Mobile App Engagement Ads to get the deferred
    // app link after your app is installed.
    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Received error while fetching deferred app link %@", error);
        }
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.windowBanner = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.windowBanner setBackgroundColor:[UIColor clearColor]];
    [self.windowBanner setHidden:YES];
    [self.windowBanner makeKeyWindow];
}

- (void)initViewController {
//    LoginViewController *rootViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    HomeViewController *rootViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    SplashViewController *rootViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
//    RegisterViewController *rootViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
}

- (void)initTabBarViewController {
    if (_homeViewController == nil) {
        _homeViewController = [[HomeViewController alloc] initWithNibName:@"_homeViewController" bundle:nil];
    }
    
//    // init where screen - all store was listed
//    WhereViewController *whereViewController = [[WhereViewController alloc] initWithNibName:@"WhereViewController" bundle:nil];
//    whereViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(StartInviteScreen, nil)
//                                                                   image:[UIImage imageNamed:@"ic_coffee_store"] tag:0];
//    _whereNavigationController = [[UINavigationController alloc]
//                                  initWithRootViewController:whereViewController];
    // init where screen - all store was listed
    StoreListViewController *storeListViewController = [[StoreListViewController alloc] initWithNibName:@"StoreListViewController" bundle:nil];
    storeListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(StartInviteScreen, nil)
                                                                   image:[UIImage imageNamed:@"ic_coffee_store"] tag:0];
    _whereNavigationController = [[UINavigationController alloc]
                                  initWithRootViewController:storeListViewController];
    
    // init friend screen - all friend was listed
    FriendRequestViewController* friendRequestViewController = [[FriendRequestViewController alloc] initWithNibName:@"FriendRequestViewController" bundle:nil];
    friendRequestViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(FriendRequestScreen, nil)
                                                                           image:[UIImage imageNamed:@"ic_friend_request"] tag:1];
    _friendNavigationController = [[UINavigationController alloc]
                                   initWithRootViewController:friendRequestViewController];
    
    // init start invite screen - creating new meeting here
    StartInviteViewController *startInviteViewController = [[StartInviteViewController alloc] initWithNibName:@"StartInviteViewController" bundle:nil];
    startInviteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(StartInviteScreen, nil)
                                                                         image:[UIImage imageNamed:@"ic_coffee_meeting"] tag:2];
    _startInviteNavigationController = [[UINavigationController alloc]
                                        initWithRootViewController:startInviteViewController];
    
    // init notification screen - all notification
    NotificationViewController *notificationViewController = [[NotificationViewController alloc] initWithNibName:@"NotificationViewController" bundle:nil];
    notificationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(NotificationScreen, nil)
                                                                          image:[UIImage imageNamed:@"ic_notification"] tag:3];
    _notificationNavigationController = [[UINavigationController alloc]
                                         initWithRootViewController:notificationViewController];
    
    //init profile screen - profile
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(ProfileScreen, nil)
                                                                     image:[UIImage imageNamed:@"ic_profile"] tag:4];
    _profileNavigationController = [[UINavigationController alloc]
                                    initWithRootViewController:profileViewController];
    
    // init array controller for tab view controller;
    NSArray* controllers = [NSArray arrayWithObjects:_whereNavigationController,
                                                    _friendNavigationController,
                                                    _startInviteNavigationController,
                                                    _notificationNavigationController,
                                                    _profileNavigationController, nil];
    _homeViewController.viewControllers = controllers;
    self.window.rootViewController = _homeViewController;
}

- (void)getDeviceId {
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    [userdefault setObject:currentDeviceId forKey:kUserDefault_DeviceId];
}

@end
