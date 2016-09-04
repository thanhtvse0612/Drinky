//
//  NotificationViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "NotificationViewController.h"
#import "Utilities.h"
#import "LocalizableDefine.h"
#import "CustomFriendRequestCell.h"
#import "CustomStoreNotificationCell.h"
#import "LocalizableDefine.h"

@interface NotificationViewController () {
     BOOL isHide;
    int btnChosen;
}
@property (weak, nonatomic) IBOutlet UIButton *btnTabFriendRequest;
@property (weak, nonatomic) IBOutlet UIButton *btnTabStoreNotification;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(NotificationScreen, nil)];
    [self doLayoutScreen];
    btnChosen = 1;
    
    isHide = NO;
    self.tabBarController.tabBar.translucent = YES;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"BarsShouldHide"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      //hide tab bar with animation;
                                                      [UIView animateWithDuration:0.3 animations:^{
                                                          for (UIView *view in self.tabBarController.view.subviews) {
                                                              if ([view isKindOfClass:[UITabBar class]] && isHide == NO) {
                                                                  [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+49.f, view.frame.size.width, view.frame.size.height)];
                                                                  //đã hide thì isHide=YEs -> ko set tăng view thêm
                                                                  isHide = YES;
                                                              }
                                                          }
                                                      } completion:^(BOOL finished) {
                                                          //do smth after animation finishes
                                                          self.tabBarController.tabBar.hidden = YES;
                                                      }];
                                                      
                                                  }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"BarsShouldUnhide"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      //Unhide tab bar with animation;
                                                      self.tabBarController.tabBar.hidden = NO;
                                                      [UIView animateWithDuration:0.3 animations:^{
                                                          for (UIView *view in self.tabBarController.view.subviews) {
                                                              if ([view isKindOfClass:[UITabBar class]] && isHide == YES) {
                                                                  [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-49.f, view.frame.size.width, view.frame.size.height)];
                                                                  //đã hiện thì set isHide = NO -> ko tăng y
                                                                  isHide = NO;
                                                              }
                                                          }
                                                      } completion:^(BOOL finished) {
                                                          //do smth after animation finishes
                                                          
                                                      }];
                                                  }];
}

- (void)doLayoutScreen {
    [_btnTabStoreNotification setBackgroundColor:[UIColor redColor]];
    [_btnTabFriendRequest setBackgroundColor:[UIColor orangeColor]];
    [_btnTabStoreNotification setTitle:NSLocalizedString(TabStoreNotification, nil) forState:UIControlStateNormal];
    [_btnTabFriendRequest setTitle:NSLocalizedString(TabFriendRequest, nil) forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - hide and unhide tabbar

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if(translation.y > 0) {
        // react to dragging down
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldUnhide"
                                                            object:self];
    } else {
        // react to dragging up
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldHide" object:self];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate {
    if(!decelerate)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldUnhide"
                                                            object:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldUnhide"
                                                        object:self];
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom <= height) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldHide" object:self];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BarsShouldUnhide" object:self];
    
}


#pragma Tap action
- (IBAction)tapStoreNotification:(id)sender {
    btnChosen = 1;
    [_btnTabStoreNotification setBackgroundColor:[UIColor redColor]];
    [_btnTabFriendRequest setBackgroundColor:[UIColor orangeColor]];
    [_tblView reloadData];
}

- (IBAction)tapFriendRequestNotification:(id)sender {
    btnChosen = 2;
    [_btnTabFriendRequest setBackgroundColor:[UIColor redColor]];
    [_btnTabStoreNotification setBackgroundColor:[UIColor orangeColor]];
    [_tblView setAllowsSelection:NO];
    [_tblView reloadData];
}


#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (btnChosen == 1) {
        static NSString *simpleTableIdentifier = @"CustomStoreNotificationCell";
        CustomStoreNotificationCell *cell = (CustomStoreNotificationCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomStoreNotificationCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        // cell information
        
        return cell;
    } else if (btnChosen == 2) {
        static NSString *simpleTableIdentifier = @"CustomFriendRequestCell";
        CustomFriendRequestCell *cell = (CustomFriendRequestCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomFriendRequestCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        // cell information
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (btnChosen == 2 ) {
        return 120;
    } else {
        return 100;
    }
}

@end
