//
//  PersonalViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 12/4/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "PersonalViewController.h"
#import "UIImageEffects.h"
#import "UIView+MHValidation.h"
#import "JSImagePickerViewController.h"
#import <AFMInfoBanner.h>

#define Gender_Male @"0"
#define Gender_Female @"1"
#define Gender_Unselected @"3"
#define Status_00 @"00"

@interface PersonalViewController () <JSImagePickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewBlurImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgSmall;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbFullname;
@property (weak, nonatomic) IBOutlet UITextField *tfFullname;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UILabel *lbBirthday;
@property (weak, nonatomic) IBOutlet UITextField *tfBirthday;
@property (weak, nonatomic) IBOutlet BlueButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (strong, nonatomic) NSDate *birthday;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;

@property (weak, nonatomic) NSString *gender;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doLayoutScreen];
    [self installValidateUITextField];
    [_imgSmall setUserInteractionEnabled:YES];
    [self addTapGesture];
    
    //set lb user birthday gusture
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.tfBirthday setInputView:datePicker];
    [self.tabBarController.tabBar setTranslucent:NO];
    
    //gender default
    _gender = Gender_Unselected;
}

-(void)updateTextField:(UIDatePicker *)sender {
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:DateFormat];
    self.tfBirthday.text = [dateFormater stringFromDate:sender.date];
    _birthday = sender.date;
}

- (void)doLayoutScreen {
    //layout image screen
    _viewBlurImage.backgroundColor = [UIColor colorWithPatternImage:[UIImageEffects imageByApplyingLightEffectToImage:[UIImage imageNamed:@"avt_1"]]];
    _imgSmall.layer.cornerRadius = _imgSmall.frame.size.width/2.0f;
    _imgSmall.layer.borderWidth = 1.0f;
    _imgSmall.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _imgSmall.layer.masksToBounds = YES;
    
    //image name
    NSString *imageName = [NSString stringWithFormat:@"%@/%@.jpg",PictureAvatar,[userdefault objectForKey:kUserDefault_AvatarName]];
    if ([[Utilities shareInstance] checkFileExistedWithPath:imageName]) {
        NSLog(@"LOG: avatar name: %@",[userdefault objectForKey:kUserDefault_AvatarName]);
        UIImage *image =[[Utilities shareInstance] getImageWithPath:imageName];
        _imgSmall.image = image;
        UIImage *imageResize = [[Utilities shareInstance] imageResize:image andResizeTo:_viewBlurImage.frame.size];
        _viewBlurImage.backgroundColor = [UIColor colorWithPatternImage:[UIImageEffects imageByApplyingLightEffectToImage:imageResize]];
    } else {
        _imgSmall.image = [UIImage imageNamed:@"imageDefault"];
        _viewBlurImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageDefault"]];
    }
    
    [self addTapGesture];
}

#pragma mark - Add gesture tap image
- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImagePickerViewController:)];
    [_imgSmall addGestureRecognizer:tapGesture];
}

- (void)showImagePickerViewController:(UITapGestureRecognizer*)tapGesutre {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:[myAppdelegate homeViewController] animated:YES];
}

#pragma mark - JSImagePickerViewControllerDelegate
- (void)imagePicker:(JSImagePickerViewController *)imagePicker didSelectImage:(UIImage *)image {
    _imgSmall.image = image;
    UIImage *imageResize = [[Utilities shareInstance] imageResize:image andResizeTo:_viewBlurImage.frame.size];
    _viewBlurImage.backgroundColor = [UIColor colorWithPatternImage:[UIImageEffects imageByApplyingLightEffectToImage:imageResize]];
}


#pragma mark - segmented control value change
- (IBAction)segmentControlValueChange:(id)sender {
    if (_segmentControl.selectedSegmentIndex == 0) {
        self.gender = Gender_Male;
    } else if (_segmentControl.selectedSegmentIndex == 1) {
        self.gender = Gender_Female;
    }
}

- (BOOL)hasSelectedGender {
    if ([_gender isEqualToString:Gender_Unselected]) {
        return NO;
    }
    return YES;
}

#pragma mark - Validation
- (void)installValidateUITextField {
    [self.scrollView setShouldShakeNonValidateObjects:YES];
    [self.scrollView MHAutoContentSizeForScrollViewWithPadding:10];
    [self.scrollView installMHValidationWithClasses:@[[UITextField class],
                                                      [UISwitch class],
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
    [self.scrollView validateWithNONMandatoryTextObjects:nil
                       validateObjectsWithMHRegexObjects:nil
                                   switchesWhichMustBeON:nil
                                      curruptObjectBlock:^(NSArray *curruptItem) {
                                          
                                      } successBlock:^(NSString *emailString, NSDictionary *valueKeyDict, NSArray *object, bool isFirstRegistration) {
                                          if ([self hasSelectedGender]) {
                                               [self callAPIUpdateInformation];
                                          } else {
                                               [AFMInfoBanner showWithText:NSLocalizedString(ErrorMessage_UnselectedGender, nil) style:AFMInfoBannerStyleError andHideAfter:3];
                                          }
                                      }];
}

- (IBAction)tapUpdate:(id)sender {
    [self validateButtonAction];
}

- (void)callAPIUpdateInformation {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSString *phoneNumber = @"0973231684";
    NSString *fullname = _tfFullname.text;
    NSString *accessToken = [userdefault objectForKey:kUserDefault_AccessToken];
    NSString *birthday = [[Utilities shareInstance]getDateTimeWithFormat:_birthday format:DateFormat];
    NSString *hId = @"THANHTV";
    NSString *gender = self.gender;
    NSString *country =_tfCountry.text;
    NSString *city = _tfCity.text;
    NSString *address = @"VTHCM";
    __block NSString *status;
    __block NSError *err;
    [APIRequest callAPIUpdateProfileWithPhoneNumber:phoneNumber fullName:fullname hId:hId address:address birthday:birthday gender:gender country:country city:city accessToken:accessToken andCompletion:^(id responseObject, NSError *error) {
        if (error) {
            status = [responseObject objectForKey:kResponse_Status];
        } else {
            err = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([status isEqualToString:Status_00]) {
            [[Utilities shareInstance] showAlertViewControllerCanCelWithTitle:@"SUCCESSFULLY"
                                                                message:@"Update Information Successfully!"
                                                         styleAlertView:LEAlertControllerStyleAlert
                                                           cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                         viewController:self];
        }
    });

}





@end
