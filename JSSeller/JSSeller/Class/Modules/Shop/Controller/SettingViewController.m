//
//  SettingViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "SettingViewController.h"
#import "ShopEditViewController.h"
#import "paymentAccountSettingViewController.h"
#import "JSPassWordViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutBT;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    self.logoutBT.layer.cornerRadius = 5;
    self.logoutBT.clipsToBounds = YES;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)logOutAction:(id)sender {
    [[JSRequestManager sharedManager] logoutWithSuccess:^(id responseObject) {
        
        [AppManager showToastWithMsg:@"已退出"];
        [self.navigationController popViewControllerAnimated:YES];
    } Failed:^(NSError *error) {
        
    }];
}

- (IBAction)storeSettingAction:(id)sender {
    ShopEditViewController *shopEditVC = [[ShopEditViewController alloc]init];
    [self.navigationController pushViewController:shopEditVC animated:YES];
}

- (IBAction)passwordSettingAction:(id)sender {
    JSPassWordViewController *passwordVC = [[JSPassWordViewController alloc] init];
    [self.navigationController pushViewController:passwordVC animated:YES];
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
