//
//  JSLoginViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/7/17.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSLoginViewController.h"
#import "JSPassWordViewController.h"
#import <JPUSHService.h>

@interface JSLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginBGView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *loginBT;
@property (weak, nonatomic) IBOutlet UIButton *verificationBT;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationTF;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation JSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    self.loginBGView.layer.cornerRadius = 5;
    self.loginBT.layer.cornerRadius = 22;
    self.verificationBT.layer.cornerRadius = 5;
}

- (IBAction)loginAction:(id)sender {
    [MBProgressHUD showMessage:@"登录中"];
    NSString *phoneStr = [_numberTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (phoneStr == nil || phoneStr.length == 0) {
        [AppManager showToastWithMsg:@"请输入账号"];
        return;
    }
    NSString *passwordStr = [_verificationTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (passwordStr == nil || passwordStr.length == 0) {
        [AppManager showToastWithMsg:@"请输入密码"];
        return;
    }
    [[JSRequestManager sharedManager] loginWithUserName:_numberTF.text Passord:_verificationTF.text Success:^(id responseObject) {
        [[JSRequestManager sharedManager] getInfoWithSuccess:^(id responseObject) {
            [MBProgressHUD hideHUD];
            NSNumber *memberid = responseObject[@"data"][@"memberid"];
            [JPUSHService setAlias:[NSString stringWithFormat:@"%@",memberid] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } Failed:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
//        [JPUSHService setAlias:_numberTF.text completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//        } seq:1];
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
    } Failed:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [AppManager showToastWithMsg:@"账号密码错误"];
    }];
}

- (IBAction)getVerificationCodeAction:(id)sender {
    NSString *phoneStr = [_numberTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (phoneStr == nil || phoneStr.length == 0) {
        [AppManager showToastWithMsg:@"请输入账号"];
        return;
    }
    
    [[JSRequestManager sharedManager] postSmsPhoneNumber:_numberTF.text Success:^(id responseObject) {
        [AppManager showToastWithMsg:@"验证短信已发送"];
        self.verificationBT.enabled = NO;
        [self.verificationBT setBackgroundColor:[UIColor lightGrayColor]];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:60 block:^(NSTimer * _Nonnull timer) {
            self.verificationBT.enabled = YES;
            [self.verificationBT setBackgroundColor:UIColorFromRGB(0x01a7ec)];
        } repeats:NO];
    } Failed:^(NSError *error) {
        [AppManager showToastWithMsg:@"验证码获取失败"];
    }];
}

- (IBAction)hiddenKeyboardAction:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (IBAction)forgetPasswordAction:(id)sender {
//    JSPassWordViewController *passwordVC = [[JSPassWordViewController alloc] init];
//    [self.navigationController pushViewController:passwordVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
