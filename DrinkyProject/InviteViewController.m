//
//  InviteViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "InviteViewController.h"
#import "CustomInviteCell.h"
#import "Utilities.h"
#import "CustomContactCell.h"
#import "LocalizableDefine.h"
#import "Store.h"
#import "DBManager.h"

@import AddressBook;
@interface InviteViewController () {
    BOOL isSearching;
    NSArray *storeList;
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
    NSMutableArray *contactList;
    Store *storeChosen;
    NSDate *datePicked;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *viewScreen1;
@property (weak, nonatomic) IBOutlet UIView *viewScreen2;
@property (weak, nonatomic) IBOutlet UIView *viewScreen3;
@property (weak, nonatomic) IBOutlet UIView *viewScreen4;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTimePicker;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarContact;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self doLayoutScreen];
    [self tapSecmentControllWhere];
    storeList = [[DBManager shareInstance] getListStore];
    contentList = [[DBManager shareInstance] getListStoreName];
    filteredContentList = [[NSMutableArray alloc] init];

}

- (void)viewDidUnload {
    [self setTableViewStore:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)doLayoutScreen {
     [_segment setEnabled:NO forSegmentAtIndex:1];
     [_segment setEnabled:NO forSegmentAtIndex:2];
     [_segment setEnabled:NO forSegmentAtIndex:3];
    [_btnNext setTitle:NSLocalizedString(ButtonNext, nil) forState:UIControlStateNormal];
    [_btnCancel setTitle:NSLocalizedString(ButtonCancel, nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapCancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentControlChange:(id)sender {
    switch (_segment.selectedSegmentIndex) {
        case 0:
        {
            [self tapSecmentControllWhere];
            break;
        }
        case 1:
        {
            [self tapSegmentControllWhen];
            break;
        }
        case 2:
        {
            [self tapSegmentControllWho];
            break;
        }
        case 3:
        {
            [self tapSegmentControllConfirm];
            break;
        }
        default:
            break;
    }
}

- (void)tapSecmentControllWhere {
    [_segment setEnabled:YES forSegmentAtIndex:0];
    _viewScreen1.hidden = NO;
    _viewScreen2.hidden = YES;
    _viewScreen3.hidden = YES;
    _viewScreen4.hidden = YES;
    _btnNext.hidden = YES;
    _lbTitle.text = NSLocalizedString(WhereViewTitle, nil);
}

- (void)tapSegmentControllWhen {
    [_segment setEnabled:YES forSegmentAtIndex:1];
    _viewScreen1.hidden = YES;
    _viewScreen2.hidden = NO;
    _viewScreen3.hidden = YES;
    _viewScreen4.hidden = YES;
    _btnNext.hidden = NO;
    _lbTitle.text = NSLocalizedString(WhenViewTitle, nil);
}

- (void)tapSegmentControllWho {
    _viewScreen1.hidden = YES;
    _viewScreen2.hidden = YES;
    _viewScreen3.hidden = NO;
    _viewScreen4.hidden = YES;
    _btnNext.hidden = YES;
    [_segment setEnabled:YES forSegmentAtIndex:2];
    _lbTitle.text = NSLocalizedString(WhoViewTitle, nil);
    // check permission to access AddressBook to get all contact
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //check if denied
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //check if authorized
        NSLog(@"Authorized");
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        [self getContactsWithAddressBook:addressBook];
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                // if denied
                NSLog(@"Just denied");
                return;
            }
            //if authorized -> get Contact
            [self getContactsWithAddressBook:addressBook];
            NSLog(@"Just authorized");
        });
    }
}

- (void) tapSegmentControllConfirm {
    _viewScreen1.hidden = YES;
    _viewScreen2.hidden = YES;
    _viewScreen3.hidden = YES;
    _viewScreen4.hidden = NO;
    _btnNext.hidden = YES;
    [_segment setEnabled:YES forSegmentAtIndex:3];
    _lbTitle.text = NSLocalizedString(ConfirmViewTitle, nil);
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    float numberSection;
    if (isSearching) {
        return 1;
    } else {
        if (_segment.selectedSegmentIndex == 0 ) {
            numberSection = contentList.count;
        } else if (_segment.selectedSegmentIndex == 2) {
            numberSection = 1;
        }
    }
    return numberSection;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    float numberRow;
    if (isSearching) {
        return [filteredContentList count];
    } else {
        if (_segment.selectedSegmentIndex == 0 ) {
            numberRow = 1;
        } else if (_segment.selectedSegmentIndex == 2) {
            numberRow = contactList.count;
        }
    }
    return numberRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segment.selectedSegmentIndex == 0) {
        static NSString *simpleTableIdentifier = @"CustomInviteCell";
        CustomInviteCell *cell = (CustomInviteCell *)[_tableViewStore dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomInviteCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        // cell information
        if (isSearching) {
            //Search Information after filter
            Store *store = [filteredContentList objectAtIndex:indexPath.row];
            cell.backgroundColor = [[Utilities shareInstance] colorWithHex:0x666666];
            cell.imgStore.image = [UIImage imageNamed:@"avt_1"];
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
            Store *store = [storeList objectAtIndex:indexPath.section];
            cell.backgroundColor = [[Utilities shareInstance] colorWithHex:0x666666];
            cell.imgStore.image = [UIImage imageNamed:@"avt_1"];
            cell.imgPrice.image = [UIImage imageNamed:@"ic_price_tag"];
            cell.imgCoffee.image = [UIImage imageNamed:@"ic_coffee"];
            cell.imgPercent.image = [UIImage imageNamed:@"ic_discount"];
            cell.imgUnknown.image = [UIImage imageNamed:@"ic_noodle"];
            cell.imgBean.image = [UIImage imageNamed:@"ic_bean"];
            cell.lbStoreName.text = store.storeName;
            cell.lbStoreAddress.text = store.storeAddress;
        }
         return cell;
    } else if (_segment.selectedSegmentIndex == 2) {
        // List contact in table view 
        static NSString *simpleTableIdentifier = @"CustomContactCell";
        CustomContactCell *cell = (CustomContactCell *)[_tableViewContact dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomContactCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        //cell information
        NSDictionary *contact = [contactList objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.imgAvatar.image = [UIImage imageNamed:@"avt_1"];
        cell.lbName.text = [contact objectForKey:@"name"];
        cell.lbPhoneNumber.text = [contact objectForKey:@"Phone"];
        
        if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
            cell.imgInstalledApp.image = [UIImage imageNamed:@"ic_intalled_app"];
        }
        return cell;

    }

    return nil;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    float heightFooter;
    if (_segment.selectedSegmentIndex == 0 ) {
        heightFooter = 10;
    } else if (_segment.selectedSegmentIndex == 2) {
        heightFooter = 0;
    }
    return heightFooter;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightRow;
    if (_segment.selectedSegmentIndex == 0 ) {
        heightRow = 100;
    } else if (_segment.selectedSegmentIndex == 2) {
        heightRow = 80;
    }
    return heightRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segment.selectedSegmentIndex == 0) {
        [self tapSegmentControllWhen];
        _segment.selectedSegmentIndex = 1;
    } else if (_segment.selectedSegmentIndex == 2) {
        _segment.selectedSegmentIndex = 3;
        [self tapSegmentControllConfirm];
    }
}
#pragma mark - Contact AddressBook
// Get the contacts.
- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
        }
        [contactList addObject:dOfPerson];
    }
    NSLog(@"Hello Contacts = %@",contactList);
    [self.tableViewContact reloadData];
}

#pragma mark - DateTimePicker
- (IBAction)tapNext:(id)sender {
    datePicked =  _dateTimePicker.date;
     _segment.selectedSegmentIndex = 2;
    [self tapSegmentControllWho];
}

#pragma mark - Search 
- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"storeName contains[c] %@", searchString];
    filteredContentList = [NSMutableArray arrayWithArray:[storeList filteredArrayUsingPredicate:resultPredicate]];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
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
    [self.tableViewStore reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}
- (IBAction)tapCancleSearch:(id)sender {
    isSearching = NO;
    [_tableViewStore reloadData];
}

@end
