//
//  paymentAccountSettingViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "paymentAccountSettingViewController.h"
#import "AlipayBindingViewController.h"
#import "BankCardBindingViewController.h"

@interface paymentAccountSettingViewController ()

@end

@implementation paymentAccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)alipayAction:(id)sender {
    AlipayBindingViewController *alipayVC = [[AlipayBindingViewController alloc]init];
    [self.navigationController pushViewController:alipayVC animated:YES];
}

- (IBAction)bankCardAction:(id)sender {
    BankCardBindingViewController *bankCardVC = [[BankCardBindingViewController alloc]init];
    [self.navigationController pushViewController:bankCardVC animated:YES];
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
