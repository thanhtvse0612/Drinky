//
//  WhereViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/19/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "WhereViewController.h"
#import "Store.h"
#import "Utilities.h"
#import "CustomWhereCell.h"
#import "DBManager.h"
#import "Define.h"
#import "AppDelegate.h"
#import "LocalizableDefine.h"
#import "PreviewViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "ListInvitationViewController.h"
#import "ConfirmViewController.h"

@interface WhereViewController () {
    BOOL isSearching;
    NSArray *storeList;
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
}
@property (weak) UIViewController *popupController;
@property (strong, nonatomic) UIViewController *ar ;
@end

@implementation WhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    storeList = [[DBManager shareInstance] getListStore];
    // get list name to search
    contentList = [[DBManager shareInstance] getListStoreName];
    filteredContentList = [[NSMutableArray alloc] init];
    [self setTitle:NSLocalizedString(WhereViewTitle, nil)];
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = NSLocalizedString(SearchPlaceHolder, nil);
    [_searchBar setTranslucent:YES];
    [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
    [self.tabBarController.tabBar setTranslucent:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
    [self addBarButon];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Invite
- (void)addBarButon {
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
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

- (void)inviteNewMeeting {
    ListInvitationViewController *listInvitationViewController = [[ListInvitationViewController alloc] initWithNibName:@"ListInvitationViewController" bundle:nil];
    [self.navigationController presentViewController:listInvitationViewController animated:YES completion:nil];
    
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    float numberRow;
    if (isSearching) {
        return [filteredContentList count];
    } else {
        numberRow = contentList.count;
    }
    return numberRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CustomWhereCell";
    CustomWhereCell *cell = (CustomWhereCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomWhereCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    // cell information
    if (isSearching && filteredContentList.count > 0) {
        //Search Information after filter
        Store *store = [filteredContentList objectAtIndex:indexPath.row];
        cell.imgStore.image = [UIImage imageNamed:@"ic_drinky"];
        cell.imgPrice.image = [UIImage imageNamed:@"ic_price_tag"];
        cell.imgCoffee.image = [UIImage imageNamed:@"ic_coffee"];
        cell.imgPercent.image = [UIImage imageNamed:@"ic_discount"];
        cell.imgUnknown.image = [UIImage imageNamed:@"ic_noodle"];
        cell.imgBean.image = [UIImage imageNamed:@"ic_bean"];
        cell.lbStoreName.text = store.storeName;
        cell.lbStoreAddress.text = store.storeAddress;
    }
    else {
        // Full store list in table view
        Store *store = [storeList objectAtIndex:indexPath.row];
        cell.imgStore.image = [UIImage imageNamed:@"ic_drinky"];
        cell.imgPrice.image = [UIImage imageNamed:@"ic_price_tag"];
        cell.imgCoffee.image = [UIImage imageNamed:@"ic_coffee"];
        cell.imgPercent.image = [UIImage imageNamed:@"ic_discount"];
        cell.imgUnknown.image = [UIImage imageNamed:@"ic_noodle"];
        cell.imgBean.image = [UIImage imageNamed:@"ic_bean"];
        cell.lbStoreName.text = store.storeName;
        cell.lbStoreAddress.text = store.storeAddress;
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightRow = 108;
    return heightRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
        ConfirmViewController *viewController = [self.navigationController.viewControllers firstObject];
        Store *store = [storeList objectAtIndex:indexPath.row];
        // save to userDefault
        [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(viewController.startInviteObj.statusObj.intValue + 1)];
        [myAppdelegate startInviteObj].store = store;
        [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
        [_searchBar resignFirstResponder];
        PreviewViewController *presentingController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];
        //store transfer
        Store *store = [storeList objectAtIndex:indexPath.row];
        presentingController.aStore = store;
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

#pragma mark - Search
- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"storeName contains[c] %@", searchString];
    filteredContentList = [NSMutableArray arrayWithArray:[storeList filteredArrayUsingPredicate:resultPredicate]];
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

#pragma mark - View animation
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.view layoutIfNeeded];
    if (size.height < 420) {
        [UIView animateWithDuration:[coordinator transitionDuration] animations:^{
            self.popupController.view.bounds = CGRectMake(0, 0, (size.height-20) * .75, size.height-20);
            [self.view layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:[coordinator transitionDuration] animations:^{
            self.popupController.view.bounds = CGRectMake(0, 0, 300, 400);
            [self.view layoutIfNeeded];
        }];
    }
}

@end

