//
//  StoreListViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/25/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "StoreListViewController.h"
#import "PreviewViewController.h"
#import "CustomStoreCell.h"
#import "ConfirmViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "ListInvitationViewController.h"

#define tagCollectionView_1_Column 1
#define tagCollectionView_2_Column 2

@interface StoreListViewController () <UICollectionViewDelegateFlowLayout, UISearchBarDelegate> {
    NSArray *storeList;
    BOOL isHide;
}
@property (nonatomic) CGRect originalFrame;
@property (nonatomic,strong) UISearchBar        *searchBar;
@property (nonatomic,strong) UIRefreshControl   *refreshControl;
@property (nonatomic,strong) NSArray        *dataSource;
@property (nonatomic,strong) NSMutableArray        *dataSourceForSearchResult;
@property (nonatomic)        BOOL           searchBarActive;
@property (nonatomic)        float          searchBarBoundsY;

@property (strong, nonatomic) UIBarButtonItem *btnTypeView;
@property (weak) UIViewController *popupController;
@property (assign, nonatomic) int tagCollectionView;

@end

@implementation StoreListViewController

static NSString * const reuseIdentifier = @"CustomStoreCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomStoreCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationController.navigationBar.translucent = NO;
    isHide = NO;
    storeList = [[DBManager shareInstance] getListStore];
    // get list name to search
    _dataSource = [[DBManager shareInstance] getListStoreName];
    _dataSourceForSearchResult = [[NSMutableArray alloc] init];
    [self setTitle:NSLocalizedString(WhereViewTitle, nil)];

    [self addBarButon];
    [self prepareRefreshControlAndSearchBar];
    _tagCollectionView = tagCollectionView_1_Column;

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
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = YES;
    self.navigationController.navigationBar.translucent = NO;
    [self prepareRefreshControlAndSearchBar];
}

-(void)dealloc{
    // remove Our KVO observer
    [self removeObservers];
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
        
        _btnTypeView = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_one_column"] style:UIBarButtonItemStylePlain target:self action:@selector(changeTypeCollectionViewTwoColumn)];
        
        self.navigationItem.rightBarButtonItems = @[barButton, _btnTypeView];
    }
}

- (void)changeTypeCollectionViewTwoColumn {
    _btnTypeView.image = [UIImage imageNamed:@"ic_two_column"];
    _btnTypeView.action = @selector(changeTypeCollectionViewOneColumn);
    _tagCollectionView = tagCollectionView_2_Column;
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)changeTypeCollectionViewOneColumn {
    _btnTypeView.image = [UIImage imageNamed:@"ic_one_column"];
    _btnTypeView.action = @selector(changeTypeCollectionViewTwoColumn);
    _tagCollectionView = tagCollectionView_1_Column;
    [self.collectionView.collectionViewLayout invalidateLayout];
}



- (void)inviteNewMeeting {
    ListInvitationViewController *listInvitationViewController = [[ListInvitationViewController alloc] initWithNibName:@"ListInvitationViewController" bundle:nil];
    [self.navigationController presentViewController:listInvitationViewController animated:YES completion:nil];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.searchBarActive) {
        return self.dataSourceForSearchResult.count;
    }
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomStoreCell *cell = (CustomStoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (indexPath.row+1)%6]];
    
    Store *store = nil;
    if (self.searchBarActive) {
        store = [_dataSourceForSearchResult objectAtIndex:indexPath.row];
    } else {
        store = [storeList objectAtIndex:indexPath.row];
    }
    
    cell.lbName.text = store.storeName;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == YES) {
        ConfirmViewController *viewController = [self.navigationController.viewControllers firstObject];
        Store *store = [storeList objectAtIndex:indexPath.row];
        // save to userDefault
        [myAppdelegate startInviteObj].statusObj = [NSNumber numberWithInt:(viewController.startInviteObj.statusObj.intValue + 1)];
        [myAppdelegate startInviteObj].store = store;
        [[Utilities shareInstance] archieverObject:[myAppdelegate startInviteObj]];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([[userdefault objectForKey:kUserDefault_isInvite] boolValue] == NO) {
//        [_searchBar resignFirstResponder];
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size;
    if (_tagCollectionView == tagCollectionView_1_Column) {
        size = CGSizeMake((rect.size.width / 1) - 12, 305);
    } else if (_tagCollectionView == tagCollectionView_2_Column) {
        size = CGSizeMake((rect.size.width / 2) - 12, 235);
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(self.searchBar.frame.size.height, 6, 6, 6);
}

#pragma mark - prepareVC
-(void)prepareRefreshControlAndSearchBar{
    [self addSearchBar];
    [self addRefreshControl];
}
-(void)addSearchBar{
    if (!self.searchBar) {
        self.searchBarBoundsY = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,self.searchBarBoundsY, [UIScreen mainScreen].bounds.size.width, 44)];
        self.searchBar.searchBarStyle       = UISearchBarStyleMinimal;
        self.searchBar.tintColor            = [UIColor blackColor];
        self.searchBar.barTintColor         = [UIColor whiteColor];
        self.searchBar.delegate             = self;
        self.searchBar.placeholder          = @"search here";
//        self.searchBar.backgroundColor = [UIColor lightGrayColor];
        self.searchBar.translucent = YES;
        
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor blackColor]];
        
        // add KVO observer.. so we will be informed when user scroll colllectionView
        [self addObservers];
    }
    
    if (![self.searchBar isDescendantOfView:self.view]) {
        [self.view addSubview:self.searchBar];
    }
}

#pragma mark - refresh control
-(void)addRefreshControl{
    if (!self.refreshControl) {
        self.refreshControl                  = [UIRefreshControl new];
        self.refreshControl.tintColor        = [UIColor grayColor];
        [self.refreshControl addTarget:self
                                action:@selector(refreashControlAction)
                      forControlEvents:UIControlEventValueChanged];
    }
    if (![self.refreshControl isDescendantOfView:self.collectionView]) {
        [self.collectionView addSubview:self.refreshControl];
    }
}

-(void)startRefreshControl{
    if (!self.refreshControl.refreshing) {
        [self.refreshControl beginRefreshing];
    }
}

#pragma mark -search
- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"storeName contains[c] %@", searchString];
    _dataSourceForSearchResult = [NSMutableArray arrayWithArray:[storeList filteredArrayUsingPredicate:resultPredicate]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //Remove all objects first.
    [_dataSourceForSearchResult removeAllObjects];
    
    if([searchText length] != 0) {
        self.searchBarActive = YES;
        [self searchTableList];
    }
    else {
        self.searchBarActive = NO;
    }
    [self.collectionView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self cancelSearching];
    [self.collectionView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchBarActive = YES;
    [self.view endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // we used here to set self.searchBarActive = YES
    // but we'll not do that any more... it made problems
    // it's better to set self.searchBarActive = YES when user typed something
    [self.searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    // this method is being called when search btn in the keyboard tapped
    // we set searchBarActive = NO
    // but no need to reloadCollectionView
    self.searchBarActive = NO;
    [self.searchBar setShowsCancelButton:NO animated:YES];
}
-(void)cancelSearching{
    self.searchBarActive = NO;
    [self.searchBar resignFirstResponder];
    self.searchBar.text  = @"";
}
#pragma mark - observer
- (void)addObservers{
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)removeObservers{
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset" context:Nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UICollectionView *)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"] && object == self.collectionView ) {
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x,
                                          self.searchBarBoundsY + ((-1* object.contentOffset.y)-self.searchBarBoundsY),
                                          self.searchBar.frame.size.width,
                                          self.searchBar.frame.size.height);
    }
}

#pragma mark - refresh actions
-(void)refreashControlAction{
    [self cancelSearching];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // stop refreshing after 2 seconds
        [self.collectionView reloadData];
        [self.refreshControl endRefreshing];
    });
}

@end
