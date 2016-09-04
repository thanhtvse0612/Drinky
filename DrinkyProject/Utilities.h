//
//  Utilities.h
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/14/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StartInvite.h"
#import "LEAlertController.h"

@interface Utilities : NSObject <UIAlertViewDelegate>
+ (instancetype) shareInstance;

- (BOOL) validateInputIsStringAndNumber:(NSString *)string;
- (BOOL)isValidEmail:(NSString *)email;
- (UIColor *)colorWithHex:(UInt32)col;
-(NSString *) stringByStrippingHTML:(NSString *)s;
- (void) showLoading;
- (void) hideLoading;
- (NSString *)convertTimeToGMTLocal:(NSDate *)date;
- (void)archieverObject:(StartInvite *)obj;
- (StartInvite *)unarchieverObject:(NSString*)strObj;

- (void)createDirectoryPath:(NSString *)directoryPath;
- (UIImage *)getImageWithPath:(NSString *)path;
- (void)saveImageWithImage:(NSData *)image andImageName:(NSString *)imageName;
- (BOOL)checkFileExistedWithPath:(NSString *)path;
- (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;
- (NSString *)getDateTimeWithFormat:(NSDate *)sourceDate format:(NSString *)format;

#pragma mark - UIAlertViewController
- (void)showAlertViewControllerLuckyWheelWithTitle:(NSString *)title
                                           message:(NSString*) message
                                    styleAlertView:(LEAlertControllerStyle)style
                                      cancelButton:(NSString *)cancelButton
                                    viewController:(UIViewController *)viewController
                                    viewLuckyWheel:(UIView *)luckyWheel;
- (void)showAlertViewControllerConfirmInviteWithTitle:(NSString *)title
                                 message:(NSString*) message
                          styleAlertView:(LEAlertControllerStyle)style
                            cancelButton:(NSString *)cancelButton
                          viewController:(UIViewController *)viewController;
- (void)showAlertViewControllerCanCelWithTitle:(NSString *)title
                                       message:(NSString*) message
                                styleAlertView:(LEAlertControllerStyle)style
                                  cancelButton:(NSString *)cancelButton
                                viewController:(UIViewController *)viewController;
@end
