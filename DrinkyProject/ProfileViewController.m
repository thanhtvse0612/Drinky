//
//  ProfileViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ProfileViewController.h"
#import "HDNotificationView.h"
#import "LEAlertController.h"
#import "SettingViewController.h"
#import "PersonalViewController.h"
#import "AccountViewController.h"
#import "APIFacebook.h"

@interface ProfileViewController () {
    UIActivityIndicatorView *activityIndicatorView;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Profile"];
    [[Utilities shareInstance] createDirectoryPath:PictureAvatar];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self doLayoutScreen];
}

#pragma mark - Do layout screen 
- (void)doLayoutScreen {
    _imgAvatar.layer.cornerRadius = _imgAvatar.bounds.size.width /2.0f;
    _imgAvatar.layer.masksToBounds = YES;
    _imgAvatar.layer.borderWidth = 1.0f;
    _imgAvatar.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //image name
    NSString *imageName = [NSString stringWithFormat:@"%@/%@.jpg",PictureAvatar,[userdefault objectForKey:kUserDefault_AvatarName]];
    if ([[Utilities shareInstance] checkFileExistedWithPath:imageName]) {
        _imgAvatar.image = [[Utilities shareInstance] getImageWithPath:imageName];
    } else if ([userdefault objectForKey:@"imageUrl"] != nil  && [[userdefault objectForKey:kUserDefault_TypeLogin]  isEqual: kUserDefault_TypeLogin_Normal]) {
        // API download image avatar
        // save image to local
    } else if ([[userdefault objectForKey:kUserDefault_TypeLogin] isEqualToString:kUserDefault_TypeLogin_Facebook]) {
        //loading
        [self addActivityIndicatorView];
        //API facebook image
        [self callAPILoadImageAvatarFacebook];
    } else {
        _imgAvatar.image = [UIImage imageNamed:@"imageDefault"];
    }
}

#pragma mark - Tap gesture

- (IBAction)tapSetting:(id)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (IBAction)tapAccount:(id)sender {
    AccountViewController *changePasswordViewController = [[AccountViewController alloc ] initWithNibName:@"AccountViewController" bundle:nil];
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}
- (IBAction)tapLogout:(id)sender {
}

- (IBAction)tapPersonal:(id)sender {
    PersonalViewController *personalViewController = [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];
    [self.navigationController pushViewController:personalViewController animated:YES];
}

#pragma mark - API
- (void)callAPILoadImageAvatarFacebook {
    __block NSDictionary *data;
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [APIFacebook getUserFields:@"picture.type(large)" callBack:^(BOOL success, id result) {
        if (success) {
            data = (NSDictionary *)result;
            dispatch_group_leave(group);
        }
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSDictionary *picture = [data objectForKey:@"picture"];
        NSDictionary *data = [picture objectForKey:@"data"];
        NSString *url = [data objectForKey:@"url"];
        NSData *dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:dataImage];
        [[Utilities shareInstance] createDirectoryPath:PictureAvatar];
        [[Utilities shareInstance] saveImageWithImage:dataImage andImageName:@"avatar"];
        [userdefault setObject:@"avatar" forKey:kUserDefault_AvatarName];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imgAvatar.image = image;
            [self removeActivityIndicatorView];
        });
    });
}

#pragma mark - Indicator view
- (void)addActivityIndicatorView {
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(CGRectGetMidX(_imgAvatar.bounds), CGRectGetMidY(_imgAvatar.bounds));
    
    [_imgAvatar addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)removeActivityIndicatorView {
    [activityIndicatorView stopAnimating];
    [activityIndicatorView removeFromSuperview];
}
@end
