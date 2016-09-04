//
//  RegisterViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/17/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "RegisterViewController.h"
#import "LocalizableDefine.h"
#import "BlueButton.h"
#import "JSImagePickerViewController.h"

@interface RegisterViewController () <JSImagePickerViewControllerDelegate> {
    BOOL tempCheck;
}
//scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbUsername;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbBirthDate;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbPassword;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet BlueButton *btnRegister;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tempCheck = NO;
    [self doLayoutScreen];
//    [_tfUsername becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [self installValidateUITextField];
}

- (void)doLayoutScreen {
    // set image avatar gesture
    [_imgAvatar setUserInteractionEnabled:YES];
    [self addTapGesture];
    
    // do layout label
    _lbBirthDate.text = NSLocalizedString(LbBirthdate, nil);
    _lbEmail.text = NSLocalizedString(LbEmail, nil);
    _lbPassword.text = NSLocalizedString(LbPassword, nil);
    _lbUsername.text = NSLocalizedString(LbUsername, nil);
    
    // do layout placeholder
    _tfPassword.placeholder = NSLocalizedString(PasswordRegisterPlaceHolder, nil);
    _tfConfirmPassword.placeholder = NSLocalizedString(ConfirmPasswordRegisterPlaceHolder, nil);
    _tfPhoneNumber.placeholder = NSLocalizedString(PhoneNumberPlaceHolder, nil);
    _tfEmail.placeholder = NSLocalizedString(EmailPlaceHolder, nil);
    _tfUsername.placeholder = NSLocalizedString(FullNamePlaceHolder, nil);
    
    //circle image avatar
    _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.width/2.0f;
    _imgAvatar.layer.borderWidth = 3.0f;
    _imgAvatar.layer.borderColor = [[UIColor whiteColor] CGColor];
    _imgAvatar.image = [UIImage imageNamed:@"ic_camera_default"];
    _imgAvatar.layer.masksToBounds = YES;
    
    //set lb user birthday gusture
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.tfBirthdate setInputView:datePicker];
    
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_login"]];
}

-(void)updateTextField:(UIDatePicker *)sender {
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"dd/MM/yyyy"];
    self.tfBirthdate.text = [dateFormater stringFromDate:sender.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Add gesture tap image
- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImagePickerViewController:)];
    [_imgAvatar addGestureRecognizer:tapGesture];
}

- (void)showImagePickerViewController:(UITapGestureRecognizer*)tapGesutre {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}

#pragma mark - JSImagePickerViewControllerDelegate
- (void)imagePicker:(JSImagePickerViewController *)imagePicker didSelectImage:(UIImage *)image {
    _imgAvatar.image = image;
}

#pragma mark - Action tap
- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Validation
- (void)installValidateUITextField {
    [self.scrollView setShouldShakeNonValidateObjects:YES];
    [self.scrollView MHAutoContentSizeForScrollViewWithPadding:10];
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
    // Validate email
    MHValidationItem *emailValidation = [[MHValidationItem alloc]initWithObject:self.tfEmail
                                                                    regexString:MHValidationRegexEmail];
    [self.scrollView validateWithNONMandatoryTextObjects:nil
                       validateObjectsWithMHRegexObjects:@[emailValidation]
                                   switchesWhichMustBeON:nil
                                      curruptObjectBlock:^(NSArray *curruptItem) {
                                          
                                      } successBlock:^(NSString *emailString, NSDictionary *valueKeyDict, NSArray *object, bool isFirstRegistration) {
                                          
                                          NSLog(@"%@",emailString);
                                          NSLog(@"%@",valueKeyDict);
                                          NSLog(@"%@",object);
                                          
                                      }];
}

- (IBAction)tapRegister:(id)sender {
    [self validateButtonAction];
    [self callAPIDoRegisterAccount];
}

#pragma mark - Call APi doRegister 
- (void)callAPIDoRegisterAccount {
    dispatch_group_t group = dispatch_group_create();
    __block NSDictionary *dict;
    __block NSError *err;
//    NSString *fullname = _tfUsername.text;
//    NSString *password = _tfPassword.text;
//    NSString *phone = _tfPhoneNumber.text;
//    NSString *email = _tfEmail.text;
//    NSString *authMethod = @"A";
    NSString *fullname = @"ThanhTV";
    NSString *password = @"123456789";
    NSString *phone = @"0122234234";
    NSString *email = @"thanhtv@gmail.com";
    NSString *authMethod = @"A";
    NSString *deviceId = [userdefault objectForKey:kUserDefault_DeviceId];
    dispatch_group_enter(group);
    [APIRequest callAPIRegisterWithFullname:fullname Password:password Phone:phone Authen:authMethod DeviceId:deviceId Email:email andCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            dict = (NSDictionary *)responseObject;
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (err) {
            [[Utilities shareInstance] showAlertViewControllerCanCelWithTitle:@"ERROR"
                                                                message:[err description]
                                                         styleAlertView:LEAlertControllerStyleAlert
                                                           cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                         viewController:self];
        }
    });
}

@end
