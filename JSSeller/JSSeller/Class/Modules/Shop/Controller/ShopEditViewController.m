//
//  ShopEditViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopEditViewController.h"
#import "JSSHUserModel.h"
#import "AJImageheadData.h"
#import "JSSHEditPhoneNumViewController.h"
#import "JSSHEditShopInfoViewController.h"
#import "JSSHEditShopNameViewController.h"
#import "JSSHEditAddressDetViewController.h"
#import "JSYHAddressMapViewController.h"

@interface ShopEditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *doneBT;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewToBottom;
@property (weak, nonatomic) IBOutlet UITextField *shopnameLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopinfoLabel;

@property (assign, nonatomic) CGFloat lat;
@property (assign, nonatomic) CGFloat lng;

@property (strong, nonatomic) NSData *logoData;

@end

@implementation ShopEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}


- (void)registUI {
    self.doneBT.layer.cornerRadius = 5;
    self.doneBT.clipsToBounds = YES;
    [self addKeyboardNotification];
    [self getConnectUserInfo];
}

- (void)getConnectUserInfo {
    [[JSRequestManager sharedManager] getInfoWithSuccess:^(id responseObject) {
        self.doneBT.enabled = YES;
        [[JSSHUserModel defaultModel] setValuesForKeysWithDictionary:responseObject[@"data"]];
        [self.shopLogoImageView setImageWithURL:[NSURL URLWithString:[JSSHUserModel defaultModel].logo] placeholder:[UIImage imageNamed:@"店铺中心默认头像"]];
        self.shopnameLabel.text = [JSSHUserModel defaultModel].shopname;
        self.phoneNumLabel.text = [JSSHUserModel defaultModel].phone;
        self.addressLabel.text = [JSSHUserModel defaultModel].address;
        self.introduceLabel.text = [JSSHUserModel defaultModel].intr_info;
        self.shopinfoLabel.text = [JSSHUserModel defaultModel].notice_info;
        _lng = [[JSSHUserModel defaultModel].lng floatValue];
        _lat = [[JSSHUserModel defaultModel].lat floatValue];
    } Failed:^(NSError *error) {
        [AppManager showToastWithMsg:@"获取失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)uploadImageAction:(id)sender {
    [[AJImageheadData  shareInstance] showActionSheetInView:self.view fromController:self completion:^(UIImage *image, NSData *iamgeData) {
        [MBProgressHUD showMessage:@"上传照片"];
        [[JSRequestManager sharedManager] putInfoWithUserModel:nil data:iamgeData Success:^(id responseObject) {
            [MBProgressHUD hideHUD];
            [AppManager showToastWithMsg:@"图片修改成功"];
            
        } Failed:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [AppManager showToastWithMsg:@"修改失败"];
        }];
        self.shopLogoImageView.image = image;
        self.logoData = iamgeData;
    } cancelBlock:^{
    }];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    [MBProgressHUD showMessage:@"修改中"];
    JSSHUserModel *userModel = [[JSSHUserModel alloc] init];
    userModel.shopname = _shopnameLabel.text;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0.00000"];
    NSNumber *lngNumber = [NSNumber numberWithFloat:_lng];
    NSNumber *latNumber = [NSNumber numberWithFloat:_lat];
    userModel.lat = latNumber;
    userModel.lng = lngNumber;
    userModel.phone = _phoneNumLabel.text;
    userModel.address = _addressLabel.text;
    userModel.intr_info = _introduceLabel.text;
    userModel.notice_info = _shopinfoLabel.text;
    userModel.is_open = [JSSHUserModel defaultModel].is_open;
    userModel.addressdet = [JSSHUserModel defaultModel].addressdet;
    userModel.contents = [JSSHUserModel defaultModel].contents;
    userModel.today_income = [JSSHUserModel defaultModel].today_income;
    userModel.month_income = [JSSHUserModel defaultModel].month_income;
    userModel.memberid = [JSSHUserModel defaultModel].memberid;
    NSData *data = nil;
    if (self.logoData != nil) {
        data = self.logoData;
    }
    [[JSRequestManager sharedManager] putInfoWithUserModel:userModel data:nil Success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failed:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [AppManager showToastWithMsg:@"修改失败"];
    }];
}


- (IBAction)locationAction:(id)sender {
//    JSYHAddressMapViewController *mapVC = [[JSYHAddressMapViewController alloc] init];
//    mapVC.chooseAddressBlock = ^(NSString *address , CGFloat lat, CGFloat lng){
//        self.addressLabel.text = address;
//        _lat = lat;
//        _lng = lng;
//    };
//    [self.navigationController pushViewController:mapVC animated:YES];
    [AppManager showToastWithMsg:@"请联系客服修改店铺地址"];
}
- (IBAction)editNameAction:(id)sender {
//    JSSHEditShopNameViewController *editNameVC = [[JSSHEditShopNameViewController alloc] init];
//    editNameVC.shopNameLabel = self.shopnameLabel;
//    [self.navigationController pushViewController:editNameVC animated:YES];
    [AppManager showToastWithMsg:@"请联系客服修改店铺名"];
}
- (IBAction)editPhoneAction:(id)sender {
    JSSHEditPhoneNumViewController *editPhoneVC = [[JSSHEditPhoneNumViewController alloc] init];
    editPhoneVC.phoneLabel = self.phoneNumLabel;
    [self.navigationController pushViewController:editPhoneVC animated:YES];
}
- (IBAction)editInfoAction:(id)sender {
    JSSHEditShopInfoViewController *editInfo = [[JSSHEditShopInfoViewController alloc] init];
    editInfo.mytitle = @"修改公告";
    editInfo.infoLabel = self.shopinfoLabel;
    [self.navigationController pushViewController:editInfo animated:YES];
}
- (IBAction)addressDetAction:(id)sender {
//    JSSHEditAddressDetViewController *editAddressDetVC = [[JSSHEditAddressDetViewController alloc] init];
//    editAddressDetVC.addressDetLabel = self.addressDetLabel;
//    [self.navigationController pushViewController:editAddressDetVC animated:YES];
}

- (IBAction)shopEditIntroduceAction:(id)sender {
    JSSHEditShopInfoViewController *editInfo = [[JSSHEditShopInfoViewController alloc] init];
    editInfo.mytitle = @"修改介绍";
    editInfo.infoLabel = self.introduceLabel;
    [self.navigationController pushViewController:editInfo animated:YES];
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请填写相关店铺公告信息"]) {
        textView.text = @"";
        textView.textColor = UIColorFromRGB(0x333333);
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = @"请填写相关店铺公告信息";
        textView.textColor = UIColorFromRGB(0xcccccc);
    }
}

#pragma mark - 添加键盘监听
- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - 移除键盘监听
- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - 键盘显示响应
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animation;
    [animationDurationValue getValue:&animation];
    
    NSValue *keyBoardFrameEndUser = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect ;
    [keyBoardFrameEndUser getValue:&keyBoardRect];
    self.scrollViewToBottom.constant = keyBoardRect.size.height;
    [self.scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
}

#pragma mark - 键盘移除响应
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollViewToBottom.constant = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeKeyboardNotification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
