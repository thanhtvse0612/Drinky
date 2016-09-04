//
//  ConfirmViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/26/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ConfirmViewController.h"
#import "WhenViewController.h"
#import "FriendRequestViewController.h"
#import "WhyViewController.h"
#import "WhereViewController.h"
#import "Define.h"
#import "Utilities.h"
#import "DBManager.h"
#import "AppDelegate.h"
#import "LocalizableDefine.h"
#import "LEAlertController.h"

#define status_00 @"00"

@interface ConfirmViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, assign) LGViewControllerFormat format;
@property (weak, nonatomic) IBOutlet UIView *viewWhere;
@property (weak, nonatomic) IBOutlet UIView *viewWho;
@property (weak, nonatomic) IBOutlet UIView *viewWhen;
@property (weak, nonatomic) IBOutlet UIView *viewWhy;

@end

@implementation ConfirmViewController

-(id)initWithFormat:(LGViewControllerFormat)format{
    
    self = [super init];
    if (self) {
        _format = format;
        _startInviteObj.statusObj = 0;
        _friendArray = [[DBManager shareInstance] getListFriend];
        _selectedArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarButon];
    [self doLayoutScreen];
    [self addTapGesture];
    [_btnConfirm setEnabled:NO];
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = YES;
    _startInviteObj = [[Utilities shareInstance] unarchieverObject:NSStringFromClass([[myAppdelegate startInviteObj] class])];
    
    if (_startInviteObj.store != nil) {
        _lbWhere.text = _startInviteObj.store.storeName;
        _btnWhere.backgroundColor = [UIColor redColor];
    }
    if (_startInviteObj.friendArray.count > 0) {
        _lbWho.text =  [NSString stringWithFormat:@"You have choose %lu friends", (unsigned long)_startInviteObj.friendArray.count];
        _btnWho.backgroundColor = [UIColor redColor];
    }
    if (_startInviteObj.timeInvitation != nil) {
        _lbWhen.text = [NSString stringWithFormat:@"%@", [[Utilities shareInstance] convertTimeToGMTLocal:_startInviteObj.timeInvitation]];
        _btnWhen.backgroundColor = [UIColor redColor];
    }
    
    if (_startInviteObj.reason.length>0) {
        _btnWhy.backgroundColor = [UIColor redColor];
        _lbWhy.text = _startInviteObj.reason;
    }
    
    
    if (_startInviteObj.statusObj.intValue >= 4) {
        if (_startInviteObj.timeInvitation != nil && _startInviteObj.store != nil && _startInviteObj.friendArray.count>0 && _startInviteObj.reason.length>0) {
            [_btnConfirm setEnabled:YES];
        }
    }
}

- (void)doLayoutScreen {
    _imgAvatar.layer.cornerRadius = _imgAvatar.bounds.size.width/2.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cancel button
- (void)addBarButon {
    UIBarButtonItem *inviteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(inviteNewMeeting)];
    [inviteButton setTintColor:[UIColor redColor]];
    self.navigationItem.leftBarButtonItem = inviteButton;
}

- (void)inviteNewMeeting {
    [userdefault setBool:NO forKey:kUserDefault_isInvite];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - move view
- (IBAction)moveToWhere:(id)sender {
    WhereViewController *whereViewController = [[WhereViewController alloc] initWithNibName:@"WhereViewController" bundle:nil];
    [self.navigationController pushViewController:whereViewController animated:YES];
}

- (IBAction)moveToWhen:(id)sender {
    WhenViewController *whenViewController = [[WhenViewController alloc] initWithNibName:@"WhenViewController" bundle:nil];
    [self.navigationController pushViewController:whenViewController animated:YES];
}

- (IBAction)moveToWho:(id)sender {
    FriendRequestViewController *friendRequestViewController = [[FriendRequestViewController alloc] initWithNibName:@"FriendRequestViewController" bundle:nil];
    [self mergeFriendList];
    friendRequestViewController.dataArray = _friendArray;
    [self.navigationController pushViewController:friendRequestViewController animated:YES];
}

- (IBAction)moveToWhy:(id)sender {
    WhyViewController *whyViewController = [[WhyViewController alloc] initWithNibName:@"WhyViewController" bundle:nil];
    [self.navigationController pushViewController:whyViewController animated:YES];
}

- (void)mergeFriendList {
    if (_startInviteObj.friendArray.count == 1) {
        for (int i = 0; i<_friendArray.count; i++) {
            Friend *selectedFriend = [_startInviteObj.friendArray firstObject];
            Friend *friend = [_friendArray objectAtIndex:i];
            if ([friend.friendUserId isEqualToString:selectedFriend.friendUserId]) {
                [_friendArray replaceObjectAtIndex:i withObject:selectedFriend];
            }
        }
    } else if (_startInviteObj.friendArray.count > 1) {
        for (int i = 0; i < _friendArray.count; i++) {
            Friend *friend = [_friendArray objectAtIndex:i];
            for (int j = 0; j < _startInviteObj.friendArray.count; j++) {
                Friend *selectedFriend = [_startInviteObj.friendArray objectAtIndex:j];
                if (friend.friendUserId == selectedFriend.friendUserId) {
                    [_friendArray replaceObjectAtIndex:i withObject:selectedFriend];
                    break;
                }
            }
        }
    }
}


#pragma mark - Confirm
- (IBAction)confirmMeeting:(id)sender {
    [self callAPICreateMeeting];
}

#pragma mark - Add tap gesture
- (void)addTapGesture {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToWho:)];
    [_viewWho addGestureRecognizer:gestureRecognizer];
    
    UITapGestureRecognizer *gestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToWhere:)];
    [_viewWhere addGestureRecognizer:gestureRecognizer1];
    
    UITapGestureRecognizer *gestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToWhen:)];
    [_viewWhen addGestureRecognizer:gestureRecognizer2];
    
    UITapGestureRecognizer *gestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToWhy:)];
    [_viewWhy addGestureRecognizer:gestureRecognizer3];
}

#pragma mark - API Confirm Meeting
- (void)callAPICreateMeeting {
    __block NSError *err;
    __block NSString *status;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    StartInvite *startInviteObj = [[Utilities shareInstance] unarchieverObject:NSStringFromClass([[myAppdelegate startInviteObj] class])];
    NSString *accessToken = [userdefault objectForKey:kUserDefault_AccessToken];
    NSString *friendIds = @"";
    for (Friend *friend in startInviteObj.friendArray) {
        friendIds = [NSString stringWithFormat:@"%@", friend.friendUserId];
        if (![friend isEqual:[startInviteObj.friendArray lastObject]]) {
            friendIds = [friendIds stringByAppendingPathComponent:@","];
        }
    }
    NSString *date = [[Utilities shareInstance] getDateTimeWithFormat:startInviteObj.timeInvitation format:DateFormat];
    NSString *startTime = [[Utilities shareInstance] getDateTimeWithFormat:startInviteObj.timeInvitation format:TimeFormat];
    [APIRequest callAPICreateMeetingWithTopic:@"1" desc:@"1" date:date startTime:startTime endTime:@"25:15" friendIds:friendIds storeId:startInviteObj.store.storeId accessToken:accessToken andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            status = [responseObject objectForKey:kResponse_Status];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([status isEqualToString:status_00]) {
            [[Utilities shareInstance] showAlertViewControllerConfirmInviteWithTitle:NSLocalizedString(AlertConfirmInvitaion_Title, nil)
                                                                             message:NSLocalizedString(AlertConfirmInvitaion_Message, nil)
                                                                      styleAlertView:LEAlertControllerStyleAlert
                                                                        cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                                      viewController:self];
            
        } else {
            [[Utilities shareInstance] showAlertViewControllerConfirmInviteWithTitle:@"ERROR"
                                                                             message:@"BUG"
                                                                      styleAlertView:LEAlertControllerStyleAlert
                                                                        cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                                      viewController:self];
            
        }
    });    
}


@end
