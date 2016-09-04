//
//  FriendRequestViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "FriendRequestViewController.h"
#import "CustomFriendsCell.h"
#import "BBBadgeBarButtonItem.h"
#import "ListInvitationViewController.h"
#import "PreviewFriendsViewController.h"
#import "Checkbox.h"
#import "ConfirmViewController.h"

@interface FriendRequestViewController () {
    BOOL isHide;
    BOOL isSearching;
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
    NSMutableArray *listFriendRecentInvite;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (weak) UIViewController *popupController;
@end

@implementation FriendRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(FriendRequestScreen, nil)];
    [self listChosenFriend];
    
    //function search
    filteredContentList = [[NSMutableArray alloc] init];
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = NSLocalizedString(SearchPlaceHolder, nil);
    [_searchBar setTranslucent:YES];
    [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
    self.navigationController.navigationBar.translucent = NO;
    
    //get list friend name
    contentList = [[DBManager shareInstance] getlIstFriendName];
    
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

- (void)viewWillAppear:(BOOL)animated {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = YES;
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
        _dataArray = [[DBManager shareInstance] getListFriend];
        //list friend recent invite
        listFriendRecentInvite = [[DBManager shareInstance] getListFriendRecentInvite];
        
    }
    [self addBarButon];
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

#pragma mark - Button Invite
- (void)addBarButon {
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
        //if select friend -> add button done
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(chooseFriendForInvitation)];
        self.navigationItem.rightBarButtonItem = barButtonItem;
    } else if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
        //Badge Button
        // If you want your BarButtonItem to handle touch event and click, use a UIButton as customView
        UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        // Add your action to your button
        [customButton addTarget:self action:@selector(inviteNewMeeting) forControlEvents:UIControlEventTouchUpInside];
        // Customize your button as you want, with an image if you have a pictogram to display for example
        [customButton setImage:[UIImage imageNamed:@"ic_new_invite"] forState:UIControlStateNormal];
        // Then create and add our custom BBBadgeBarButtonItem
        BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
        // Set a value for the badge
        barButton.badgeValue = @"5";
        barButton.badgeOriginX = 13;
        barButton.badgeOriginY = -9;
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)chooseFriendForInvitation {
    [self listChosenFriend];
    ConfirmViewController *confirmViewController = [[self.navigationController viewControllers] firstObject];
    confirmViewController.selectedArray = _selectedArray;
    //save startInviteObj AppDelegate
    [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(confirmViewController.startInviteObj.statusObj.intValue + 1)];
    [myAppdelegate startInviteObj].friendArray = _selectedArray;
    //save to userDefault
    [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
    //send back data to confirm view
    confirmViewController.friendArray = _dataArray;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inviteNewMeeting {
    ListInvitationViewController *listInvitationViewController = [[ListInvitationViewController alloc] initWithNibName:@"ListInvitationViewController" bundle:nil];
    [self.navigationController presentViewController:listInvitationViewController animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    float numberRow;
    if (isSearching) {
        return [filteredContentList count];
    } else {
        numberRow = contentList.count;
    }
    return numberRow;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (listFriendRecentInvite.count > 0) {
        return 2;
    } else {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CustomFriendsCell";
    CustomFriendsCell *cell = (CustomFriendsCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomFriendsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // cell information
    //if isSearching -> check bool and filter list
    if ([_tblView numberOfSections] == 1) {
        if (isSearching && filteredContentList.count > 0) {
            Friend *friend = [filteredContentList objectAtIndex:indexPath.row];
            cell.lbName.text = friend.friendDisplayName;
            cell.viewCheckBox.hidden = YES;
        } else  {
            // if not -> load cell normally
            Friend *friend = [_dataArray objectAtIndex:indexPath.row];
            cell.lbName.text = friend.friendDisplayName;
            if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
                cell.viewCheckBox.hidden = NO;
                cell.viewCheckBox.checked = friend.statusChosen;
                // Accessibility
                [self updateAccessibilityForCell:cell];
            } else if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
                cell.viewCheckBox.hidden = YES;
            }
        }
    }
   

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightRow = 80;
    return heightRow;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_searchBar resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
        // choose friends
        NSLog(@"choose friends");
        // Find the cell being touched and update its checked/unchecked image.
        CustomFriendsCell *targetCustomCell = (CustomFriendsCell *)[tableView cellForRowAtIndexPath:indexPath];
        targetCustomCell.viewCheckBox.checked = !targetCustomCell.viewCheckBox.checked;
        // Don't keep the table selection.
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        // get obj friend to replace
        Friend *friend = [_dataArray objectAtIndex:indexPath.row];
        friend.statusChosen = targetCustomCell.viewCheckBox.isChecked;
        [_dataArray replaceObjectAtIndex:indexPath.row withObject:friend];
        // Accessibility
        [self updateAccessibilityForCell:targetCustomCell];
    } else if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
        // show preview friend
        Friend *friend = [_dataArray objectAtIndex:indexPath.row];
        PreviewFriendsViewController *presentingController = [[PreviewFriendsViewController alloc] initWithNibName:@"PreviewFriendsViewController" bundle:nil];
        presentingController.aFriend = friend;
        CCMPopupTransitioning *popup = [CCMPopupTransitioning sharedInstance];
        if (self.view.bounds.size.height < 420) {
            popup.destinationBounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height-20) * .75, [UIScreen mainScreen].bounds.size.height-20);
        } else {
            popup.destinationBounds = CGRectMake(0, 0, 300, 400);
        }
        popup.presentedController = presentingController;
        popup.presentingController = self;
        popup.dismissableByTouchingBackground = YES;
        self.popupController = presentingController;
        [self presentViewController:presentingController animated:YES completion:nil];
    }
}

// delegate for checkbox view (fix later)
- (IBAction)checkBoxTapped:(id)sender forEvent:(UIEvent*)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tblView];
    
    // Lookup the index path of the cell whose checkbox was modified.
    NSIndexPath *indexPath = [self.tblView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        Friend *friend = [_dataArray objectAtIndex:indexPath.row];
        // Update our data source array with the new checked state.
        [_selectedArray addObject:friend];
    }
    // Accessibility
    [self updateAccessibilityForCell:(CustomFriendsCell*)[self.tblView cellForRowAtIndexPath:indexPath]];
}

- (void)updateAccessibilityForCell:(CustomFriendsCell*)cell {
    // The cell's accessibilityValue is the Checkbox's accessibilityValue.
    cell.accessibilityValue = cell.viewCheckBox.accessibilityValue;
    cell.viewCheckBox.accessibilityLabel = cell.lbName.text;
}


- (void)listChosenFriend {
    // create list selected friend in viewcontroller
    _selectedArray =[[NSMutableArray alloc] init];
    Friend *friend ;
    for (int i = 0; i < _dataArray.count; i++) {
        friend = [_dataArray objectAtIndex:i];
        if (friend.statusChosen == YES) {
            [_selectedArray addObject:friend];
        }
    }
}

#pragma mark - SearchBar
- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"friendDisplayName contains[c] %@", searchString];
    filteredContentList = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:resultPredicate]];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self searchTableList];
    isSearching = YES;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.tblView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancel");
    [_searchBar resignFirstResponder];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}


@end
