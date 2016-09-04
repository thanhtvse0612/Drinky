//
//  LoginViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/16/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UIView+MHValidation.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "APIFacebook.h"

#define status_03 @"03"
#define status_00 @"00"


@interface LoginViewController () {
    FBSDKLoginManager *loginManager;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet BlueButton *btnLogin;
@property (strong, nonatomic) UIView *line;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    [super viewDidLoad];
    [self doLayoutScreen];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTranslucent:YES];
    [self installValidateUITextField];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) doLayoutScreen {
    // init layout
    [_btnLogin setTitle:NSLocalizedString(LoginButtonName, nil) forState:UIControlStateNormal];
    _btnLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    _btnLogin.layer.borderWidth = 1;
    _btnLogin.layer.backgroundColor = [[UIColor orangeColor] CGColor];
    _btnLogin.layer.cornerRadius = 5;
    
    [_logoImage setImage:[UIImage imageNamed:@"ic_drinky"]];
    
    //set placeholder
    _tfPhoneNumber.placeholder = NSLocalizedString(PhoneNumberPlaceHolder, nil);
    _tfPassword.placeholder = NSLocalizedString(PasswordPlaceHolder, nil);
    
    // Line between 2 text field
    _line = [[UIView alloc] initWithFrame:CGRectMake(1, 30,10, 5)];
    _line.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:_line];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_login"]];
    
    [_btnBack setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
//    _btnFacebookLogin.backgroundColor=[UIColor darkGrayColor];
//    _btnFacebookLogin.frame=CGRectMake(0,0,180,40);
//    _btnFacebookLogin.center = self.view.center;
//    [_btnFacebookLogin setTitle: @"My Login Button" forState: UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark - Gesture Tap 
- (void) addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [_tfPassword resignFirstResponder];
    [_tfPhoneNumber resignFirstResponder];
}

- (IBAction)tapLogin:(id)sender {
    [userdefault setBool:NO forKey:kUserDefault_isInvite];
    [self validateButtonAction];
}

- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Validation
- (void)installValidateUITextField {
    [self.scrollView setShouldShakeNonValidateObjects:YES];
    [self.scrollView MHAutoContentSizeForScrollViewWithPadding:0];
    [self.scrollView installMHValidationWithClasses:@[[UITextField class],
                                                      [UISwitch class],
                                                      [UISegmentedControl class],
                                                      [UITextView class]
                                                      ]
                              setCustomizationBlock:^(MHTextObjectsCustomization *customization) {
                                  customization.selectedCustomization.borderColor = [UIColor lightGrayColor];
                              }];
    [self.scrollView setShouldShakeNonValidateObjects:YES];
    [self.scrollView setShowNextAndPrevSegmentedControl:YES];
    [self.scrollView setShouldEnableNextObjectSelectionWithEnter:YES];
    [self.scrollView setShouldSaveTextInput:YES];
    
}

- (void)validateButtonAction{
    // validate input empty
    [self.scrollView validateWithNONMandatoryTextObjects:nil
                       validateObjectsWithMHRegexObjects:nil
                                   switchesWhichMustBeON:nil
                                      curruptObjectBlock:^(NSArray *curruptItem) {
                                          
                                      } successBlock:^(NSString *emailString, NSDictionary *valueKeyDict, NSArray *object, bool isFirstRegistration) {
                                          NSLog(@"LOG: Validate OK");
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                          // dismiss keyboard first
                                          [self dismissKeyboard];
                                          //show loading
                                          [[Utilities shareInstance] showLoading];
                                          // call API
                                          [self callAPILogin];
                                          
                                      }];
}

#pragma mark - Login
- (void)callAPILogin {
    NSString *phone = @"0973231684";
    NSString *password = @"12345678";
//    NSString *phone = @"123456789";
//    NSString *password = @"123456789";
    dispatch_group_t group = dispatch_group_create();
    __block NSDictionary *dict;
    __block NSError *err;
    __block  NSString *status;
//    NSString *deviceId = [userdefault objectForKey:kUserDefault_DeviceId];
    NSString *deviceId = @"DEC6CFE6-082D-432D-BE18-8260E48AC662";
    dispatch_group_enter(group);
    [APIRequest callAPILoginWithPhone:phone Password:password DeviceId:deviceId AuthMethod:@"asd" andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            dict = [responseObject objectForKey:kResponse_Data];
            status = [responseObject objectForKey:kResponse_Status];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!err) {
            if ([status isEqualToString:status_03]) {
                [[Utilities shareInstance] hideLoading];
                [self dismissViewControllerAnimated:YES completion:nil];
        
                [[Utilities shareInstance] showAlertViewControllerCanCelWithTitle:@"WARNING"
                                                                    message:@"Your phone or password was incorrect"
                                                             styleAlertView:LEAlertControllerStyleAlert
                                                               cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                             viewController:[[[myAppdelegate navigationController] viewControllers] firstObject]];

            } else if ([status isEqualToString:status_00]) {
                [self saveDataUserLoginWithData:dict];
                [self callAPIGetFriendList];
            }
        }
    });
}

- (void)saveDataUserLoginWithData:(NSDictionary *)dict {
    [userdefault setObject:[dict objectForKey:kResponse_AccessToken] forKey:kUserDefault_AccessToken];
    [userdefault setObject:[dict objectForKey:kResponse_AvatarImageLink] forKey:kUserDefault_AvatarImageLink];
    [userdefault setObject:[dict objectForKey:kResponse_DisplayName] forKey:kUserDefault_DisplayName];
    [userdefault setObject:[dict objectForKey:kResponse_Email] forKey:kUserDefault_Email];
    [userdefault setObject:[dict objectForKey:kResponse_PhoneNumber] forKey:kUserDefault_PhoneNumber];
    [userdefault setObject:[dict objectForKey:kResponse_UserId] forKey:kUserDefault_UserId];
    [userdefault setObject:[NSNumber numberWithBool:YES] forKey:kUserDefault_isLoginBefore];
}



#pragma mark - Login facebook button 
- (IBAction)tapFacebookLogin:(id)sender {
    [APIFacebook loginBehavior:FBSDKLoginBehaviorBrowser fromViewController:self CallBack:^(BOOL success, id result) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[Utilities shareInstance] showLoading];
            });
            NSLog(@"Success");
        } else {
            NSLog(@"%@", [result description]);
        }
    }];
}

#pragma mark - Observations

- (void)observeProfileChange:(NSNotification *)notfication {
    if ([FBSDKProfile currentProfile]) {
     
        __block NSDictionary *dict;
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        [APIFacebook getUserFields:@"id, name, email, birthday" callBack:^(BOOL success, id result) {
            if (success) {
                dict = (NSDictionary *)result;
                dispatch_group_leave(group);
            } else {
                NSLog(@"ERROR: %@", [result description]);
            }
        }];
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"came here");
            [self dismissViewControllerAnimated:YES completion:^{
                   [[Utilities shareInstance] showLoading];
                RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
                
                UIViewController *view = [[[myAppdelegate navigationController] viewControllers] firstObject];
                [view presentViewController:registerViewController animated:YES completion:^{
                    registerViewController.tfEmail.text = [dict objectForKey:@"email"];
                    registerViewController.tfUsername.text = [dict objectForKey:@"name"];
                    registerViewController.tfBirthdate.text = [dict objectForKey:@"birthday"];
                    [[Utilities shareInstance] hideLoading];
                }];
            }];
        });
    }
}

- (void)observeTokenChange:(NSNotification *)notfication {
    if (![FBSDKAccessToken currentAccessToken]) {
        NSLog(@"LOG: Token not change");
    } else {
        [self observeProfileChange:nil];
    }
}

#pragma mark - call API get friend list
- (void)callAPIGetFriendList {
    dispatch_group_t group = dispatch_group_create();
    NSString *accessToken = [userdefault objectForKey:kUserDefault_AccessToken];
    __block NSArray *array;
    __block NSError *err;
    dispatch_group_enter(group);
    [APIRequest callAPIGetFriendListWithAccessToken:accessToken  andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            array = [responseObject objectForKey:kResponse_Data];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // save friend list to db
        [[DBManager shareInstance] saveListFriendWithData:array andFriendRecentInvite:[NSNumber numberWithInt:0]];
        [self callAPIGetStoreList];
    });
}

#pragma mark - API for StoreList
- (void)callAPIGetStoreList {
    dispatch_group_t group = dispatch_group_create();
    NSString *accessToken = [userdefault objectForKey:kUserDefault_AccessToken];
    __block NSArray *arrayStoreList;
    __block NSError *err;
    dispatch_group_enter(group);
    [APIRequest callAPIGetStoreListWithAccessToken:accessToken andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            arrayStoreList = [responseObject objectForKey:kResponse_Data];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // save friend list to db
        [self saveStoreListToDatabase:arrayStoreList];
        [[Utilities shareInstance] hideLoading];
        [myAppdelegate initTabBarViewController];
    });
}

- (void)saveStoreListToDatabase:(NSArray *)arrStoreList {
    for (int i = 0; i < arrStoreList.count; i++) {
        NSDictionary *store = [arrStoreList objectAtIndex:i];
        Store *storeObj = [[Store alloc] init];
        storeObj.storeId = [store objectForKey:kResponse_StoreId];
        storeObj.storeName = [store objectForKey:kResponse_StoreName] ;
        storeObj.storeAddress = [store objectForKey:kResponse_StoreAddress];
        storeObj.storeLatitude = [store objectForKey:kResponse_StoreLatitude];
        storeObj.storeLongitude = [store objectForKey:kResponse_StoreLongitude];
        storeObj.storeFeatureImage = [store objectForKey:kResponse_StoreFeatureImage];
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[[store objectForKey:kResponse_StoreDescription] dataUsingEncoding:NSUTF8StringEncoding]
                                                                               options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                         NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                    documentAttributes:nil error:nil];
        storeObj.storeDescription = attributeString.string;
        storeObj.storePhone = [store objectForKey:kResponse_StorePhone];
        storeObj.storeTwitterUrl = [store objectForKey:kResponse_StoreTwitterUrl];
        storeObj.storeFacebookUrl = [store objectForKey:kResponse_StoreFacebookUrl];
        storeObj.storeGoogleUrl = [store objectForKey:kResponse_StoreGoogleUrl];
        storeObj.storeInstagramUrl = [store objectForKey:kResponse_StoreInstagramUrl];
        storeObj.storeOpenTime = [store objectForKey:kResponse_StoreOpenTime];
        storeObj.storeCloseTime = [store objectForKey:kResponse_StoreCloseTime];
        storeObj.storeDayInWeek = [store objectForKey:kResponse_StoreDayInweek];
        storeObj.storeAvgPrice = [store objectForKey:kResponse_StoreAvgPrice];
        storeObj.storeRatingScore = [store objectForKey:kResponse_StoreRatingScore];
        storeObj.storeDefaultExchange = [store objectForKey:kResponse_StoreDefaultExchangeRate];
        storeObj.storeDistance = [store objectForKey:kResponse_StoreDistance];
        storeObj.storeIsFavorite = [store objectForKey:kResponse_StoreIsFavorite];
        
        NSDictionary *scoreDetailList = [store objectForKey:kResponse_StoreScoreDetailList];
        NSDictionary *decorateCriteria = [scoreDetailList objectForKey:kResponse_StoreScoreDetailList_DecorateCriteria];;
        NSNumber *scoreDecorateCriteria = [decorateCriteria objectForKey:kResponse_StoreScoreDetailList_Score];
        
        NSDictionary *locationCriteria = [scoreDetailList objectForKey:kResponse_StoreScoreDetailList_LocationCriteria];
        NSNumber *scoreLocationCriteria = [locationCriteria objectForKey:kResponse_StoreScoreDetailList_Score];
        
        NSDictionary *serviceCriteria = [scoreDetailList objectForKey:kResponse_StoreScoreDetailList_ServiceCriteria];
        NSNumber *scoreServiceCriteria = [serviceCriteria objectForKey:kResponse_StoreScoreDetailList_Score];
        
        NSDictionary *costCriteria = [scoreDetailList objectForKey:kResponse_StoreScoreDetailList_CostCriteria];
        NSNumber *scoreCostCriteria = [costCriteria objectForKey:kResponse_StoreScoreDetailList_Score];
        
        NSDictionary *qualityCriteria = [scoreDetailList objectForKey:kResponse_StoreScoreDetailList_QualityCriteria];
        NSNumber *scoreQualityCriteria = [qualityCriteria objectForKey:kResponse_StoreScoreDetailList_Score];
        
        NSDictionary *scoreDetailListDictionary = [NSDictionary dictionaryWithObjectsAndKeys:scoreDecorateCriteria, @"scoreDecorateCriteria",
                                                                                            scoreLocationCriteria, @"scoreLocationCriteria",
                                                                                            scoreServiceCriteria, @"scoreServiceCriteria",
                                                                                            scoreCostCriteria, @"scoreCostCriteria",
                                                                                            scoreQualityCriteria, @"scoreQualityCriteria",
                                                                                            nil];

        storeObj.storeScoreDetailList = [self createStringJsonWithDictionary:scoreDetailListDictionary];
    
        //ClassifyFilterList
        if (![[store valueForKey:kResponse_ClassifyTypeList] isKindOfClass:[NSNull class]]) {
            NSArray *classifyTypeFiltersArray = [[store objectForKey:kResponse_ClassifyTypeList] objectForKey:kResponse_ClassifyTypeList_ClassifyTypeFilters];
            storeObj.storeClassifyTypeFilter= [self createJsonStringFromClassifyTypeFilters:classifyTypeFiltersArray];
        } else {
            storeObj.storeClassifyTypeFilter = @"";
        }
        [[DBManager shareInstance] saveListStoreWithData:storeObj];
    
    }

}

#pragma mark - Create string classify type filter to save
- (NSString *)createJsonStringFromClassifyTypeFilters:(NSArray *)classifyTypeFiltersArray {
    NSMutableDictionary *classifyTypeListDictionary = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in classifyTypeFiltersArray) {
        NSString *classifyTypeFiltersName = [dict objectForKey:kResponse_ClassifyTypeList_ClassifyTypeFilters_Name];
        
        NSArray *classifies = [dict objectForKey: kResponse_ClassifyTypeList_ClassifyTypeFilters_Classifies];
        NSString *strJsonClassify = @"";
        for (NSDictionary *classifyItem in classifies) {
            NSString *classifiesName = [classifyItem objectForKey:kResponse_ClassifyTypeList_ClassifyTypeFilters_Classifies_Name];
            strJsonClassify = [strJsonClassify stringByAppendingString:classifiesName];
            strJsonClassify = [strJsonClassify stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            strJsonClassify = [strJsonClassify stringByAppendingPathComponent:@";"];
        }
        [classifyTypeListDictionary setObject:strJsonClassify forKey:classifyTypeFiltersName];
    }
    return [self createStringJsonWithDictionary:classifyTypeListDictionary];
}

- (NSString *)createStringJsonWithDictionary:(id)dict{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}




@end
