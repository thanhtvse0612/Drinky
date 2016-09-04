//
//  ListInvitationViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "ListInvitationViewController.h"
#import "Define.h"
#import "AppDelegate.h"
#import "LocalizableDefine.h"
#import "CustomInvitationCell.h"
#import "Utilities.h"

@interface ListInvitationViewController () {
    int viewChosen;
}

@end

@implementation ListInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:NSLocalizedString(ListInvitationScreen, nil)];
    [self doLayoutScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doLayoutScreen {
    [_btnAll setBackgroundColor:[UIColor redColor]];
    [_btnFromMe setBackgroundColor:[UIColor orangeColor]];
    [_btnToMe setBackgroundColor:[UIColor orangeColor]];
    
    //set color view
    [_viewSelection setBackgroundColor:[[Utilities shareInstance] colorWithHex:colorPrimaryDark]];
    [_viewNavigation setBackgroundColor:[[Utilities shareInstance] colorWithHex:colorPrimary]];
    [_btnAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnToMe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnFromMe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnAll setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_btnToMe setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_btnFromMe setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}

#pragma mark - Tap Filter Invitation
- (IBAction)tapBtnAll:(id)sender {
    viewChosen = 1;
    [_btnAll setBackgroundColor:[UIColor redColor]];
    [_btnFromMe setBackgroundColor:[UIColor orangeColor]];
    [_btnToMe setBackgroundColor:[UIColor orangeColor]];
}

- (IBAction)tapBtnFromMe:(id)sender {
    viewChosen = 2;
    [_btnAll setBackgroundColor:[UIColor orangeColor]];
    [_btnFromMe setBackgroundColor:[UIColor redColor]];
    [_btnToMe setBackgroundColor:[UIColor orangeColor]];
}

- (IBAction)tapBtnToMe:(id)sender {
    viewChosen = 3;
    [_btnAll setBackgroundColor:[UIColor orangeColor]];
    [_btnFromMe setBackgroundColor:[UIColor orangeColor]];
    [_btnToMe setBackgroundColor:[UIColor redColor]];
}

- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CustomInvitationCell";
    CustomInvitationCell *cell = (CustomInvitationCell *)[_tblAll dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomInvitationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    // cell information
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float heightRow = 178;
    return heightRow;
}

@end
