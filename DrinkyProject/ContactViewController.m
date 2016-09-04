//
//  ContactViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/19/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ContactViewController.h"
#import "CustomContactCell.h"

@import AddressBook;
@interface ContactViewController () {
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
    NSMutableArray *contactList;
    BOOL isSearching;
}

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    float numberRow;
    if (isSearching) {
        return [filteredContentList count];
    } else {
        numberRow = contactList.count;
    }
    return numberRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CustomContactCell";
    CustomContactCell *cell = (CustomContactCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomContactCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    // cell information
    if (isSearching) {
        //Search Information after filter
        NSDictionary *contact = [filteredContentList objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.imgAvatar.image = [UIImage imageNamed:@"avt_1"];
        cell.lbName.text = [contact objectForKey:@"name"];
        cell.lbPhoneNumber.text = [contact objectForKey:@"Phone"];
        
        if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
            cell.imgInstalledApp.image = [UIImage imageNamed:@"ic_intalled_app"];
        }
    }
    else {
        //cell information
        NSDictionary *contact = [contactList objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.imgAvatar.image = [UIImage imageNamed:@"avt_1"];
        cell.lbName.text = [contact objectForKey:@"name"];
        cell.lbPhoneNumber.text = [contact objectForKey:@"Phone"];
        
        if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
            cell.imgInstalledApp.image = [UIImage imageNamed:@"ic_intalled_app"];
        }
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    float heightFooter = 50;
    return heightFooter;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightRow = 80;
    return heightRow;
}

#pragma mark - Search
- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchString];
    filteredContentList = [NSMutableArray arrayWithArray:[contactList filteredArrayUsingPredicate:resultPredicate]];
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
    [self.tblView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
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
    [self.tblView reloadData];
}
@end
