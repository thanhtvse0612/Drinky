//
//  Utilities.m
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/14/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#import "Utilities.h"
#import "Define.h"
#import "AppDelegate.h"
#import "StartInvite.h"
#import "UIAlertView+LEBlocks.h"
#import "UIActionSheet+LEBlocks.h"
#import "LEAlertController.h"

#define tag_loading_view 01

static Utilities *shareInstance;
static UIAlertView *alert;

@implementation Utilities

+ (instancetype) shareInstance {
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        if (shareInstance == nil) {
            shareInstance = [[Utilities alloc] init];
        }
    });
    return shareInstance;
}

- (void)showAlertWithMessage:(NSString *)message andTitle:(NSString *)title delegate:(id)delegate{
    alert = [[UIAlertView alloc]initWithTitle:title
                                      message:message
                                     delegate:delegate
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
    
    [alert show];
}

- (BOOL) validateInputIsStringAndNumber:(NSString *)string {
    NSString *str = @"aA09";
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL valid = [[str stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    return valid;
}

- (BOOL)isValidEmail:(NSString *)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

-(NSString *) stringByStrippingHTML:(NSString *)s {
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void) showLoading{
    if ([[[myAppdelegate navigationController] view] viewWithTag:tag_loading_view]) {
        return;
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView * tmpView = [[UIView alloc] initWithFrame:screenRect];
    tmpView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = tmpView.center;
    [tmpView addSubview:activityView];
    [activityView startAnimating];
    tmpView.tag = tag_loading_view;
    
    [[[myAppdelegate navigationController] view] addSubview:tmpView];
    [[[myAppdelegate navigationController]view] bringSubviewToFront:tmpView];
}

- (void) hideLoading{
    [[[[myAppdelegate navigationController] view] viewWithTag:tag_loading_view] removeFromSuperview];
}

- (NSString *)convertTimeToGMTLocal:(NSDate *)date {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    //Create the date assuming the given string is in GMT
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //Create a date string in the local timezone
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSString *localDateString = [df stringFromDate:date];
    NSLog(@"date = %@", localDateString);
    return localDateString;
}

- (NSString *)getDateTimeWithFormat:(NSDate *)sourceDate format:(NSString *)format {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *localDateString = [dateFormatter stringFromDate:sourceDate];
    return localDateString;
}


- (void)archieverObject:(StartInvite *)obj {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:NSStringFromClass([obj class])];
}

- (StartInvite *)unarchieverObject:(NSString*)strObj {
    NSData *notesData = [[NSUserDefaults standardUserDefaults] objectForKey:strObj];
    StartInvite *notes = [NSKeyedUnarchiver unarchiveObjectWithData:notesData];
    return notes;
}

#pragma mark - UIAlertViewController
- (void)showAlertViewControllerConfirmInviteWithTitle:(NSString *)title
                                 message:(NSString*) message
                          styleAlertView:(LEAlertControllerStyle)style
                            cancelButton:(NSString *)cancelButton
                          viewController:(UIViewController *)viewController{
    LEAlertController *alertController = [LEAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    LEAlertAction *cancelAction = [LEAlertAction actionWithTitle:cancelButton style:LEAlertActionStyleCancel handler:^(LEAlertAction *action) {
        // handle cancel button action
        NSLog(@"cancel button pressed");
        [userdefault setBool:NO forKey:kUserDefault_isInvite];
        [[myAppdelegate startInviteObj] setStore:nil];
        [[myAppdelegate startInviteObj] setFriendArray:nil];
        [[myAppdelegate startInviteObj] setStatusObj:[NSNumber numberWithInt:0]];
        [[myAppdelegate startInviteObj] setTimeInvitation:nil];
        [[myAppdelegate startInviteObj] setReason:@""];
        [self archieverObject:[myAppdelegate startInviteObj]];
        [viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    
    [viewController presentAlertController:alertController animated:YES completion:nil];
}

- (void)showAlertViewControllerLuckyWheelWithTitle:(NSString *)title
                                           message:(NSString*) message
                                    styleAlertView:(LEAlertControllerStyle)style
                                      cancelButton:(NSString *)cancelButton
                                    viewController:(UIViewController *)viewController
                                    viewLuckyWheel:(UIView *)luckyWheel {
    LEAlertController *alertController = [LEAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    LEAlertAction *cancelAction = [LEAlertAction actionWithTitle:cancelButton style:LEAlertActionStyleCancel handler:^(LEAlertAction *action) {
        // handle cancel button action
        NSLog(@"cancel button pressed");
        luckyWheel.transform = CGAffineTransformIdentity;
    }];
    [alertController addAction:cancelAction];
    
    [viewController presentAlertController:alertController animated:YES completion:nil];
}

- (void)showAlertViewControllerCanCelWithTitle:(NSString *)title
                                                  message:(NSString*) message
                                           styleAlertView:(LEAlertControllerStyle)style
                                             cancelButton:(NSString *)cancelButton
                                           viewController:(UIViewController *)viewController {
    LEAlertController *alertController = [LEAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    LEAlertAction *cancelAction = [LEAlertAction actionWithTitle:cancelButton style:LEAlertActionStyleCancel handler:^(LEAlertAction *action) {
        // handle cancel button action
        NSLog(@"cancel button pressed");
    }];
    [alertController addAction:cancelAction];
    
    [viewController presentAlertController:alertController animated:YES completion:nil];
}



#pragma mark - Image 
- (UIImage *)getImageWithPath:(NSString *)path {
    if ([self checkFileExistedWithPath:path]) {
        NSString *getImagePath = [[self documentSearchPathForDirectories] stringByAppendingPathComponent:path];
        UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        return img;
    } else {
        NSLog(@"ERROR: ko co file ");
    }
    return nil;
}

- (void)saveImageWithImage:(NSData *)image andImageName:(NSString *)imageName{
    NSString *getImagePath = [[self documentSearchPathForDirectories] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.jpg",PictureAvatar,imageName]];
    NSError *error;
    if ([image writeToFile:getImagePath options:NSDataWritingFileProtectionNone error:&error]) {
        NSLog(@"LOG: Save Successfully");
    }
}

- (BOOL)checkFileExistedWithPath:(NSString *)path {
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* file = [documentsPath stringByAppendingPathComponent:path];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:file];
    return fileExists;
}

#pragma mark - Create document directory 
- (NSString *)documentSearchPathForDirectories {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return (paths.count)? paths[0] : nil;
}
- (void)createDirectoryPath:(NSString *)directoryPath {
    NSString *namePath = [[self documentSearchPathForDirectories] stringByAppendingPathComponent:directoryPath];
    NSString *path = [NSString stringWithFormat:@"file://%@",namePath];
    NSURL *url = [NSURL URLWithString:path];
    NSError *error;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:namePath] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"ERROR: %@", [error description]);
        }
    }
}

#pragma mark - Resize iamge 
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen]scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
