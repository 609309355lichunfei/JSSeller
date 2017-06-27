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

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)storeSettingAction:(id)sender {
    ShopEditViewController *shopEditVC = [[ShopEditViewController alloc]init];
    [self.navigationController pushViewController:shopEditVC animated:YES];
}

- (IBAction)passwordSettingAction:(id)sender {
    paymentAccountSettingViewController *paymentSettingVC = [[paymentAccountSettingViewController alloc]init];
    [self.navigationController pushViewController:paymentSettingVC animated:YES];
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
