//
//  ShopController.m
//  YYSeller
//
//  Created by 李春菲 on 17/6/16.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopController.h"
#import "SettingViewController.h"
#import "TurnoverViewController.h"
#import "ZJSwitch.h"
#import "paymentAccountSettingViewController.h"
#import "ServiceCenterViewController.h"
#import "AboutUsViewController.h"

@interface ShopController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *switchBGView;

@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    
//    //  毛玻璃view 视图
//    
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    //添加到要有毛玻璃特效的控件中
//    
//    effectView.frame = self.backgroundImageView.bounds;
//    
//    [self.backgroundImageView addSubview:effectView];
    
    ZJSwitch *switch0 = [[ZJSwitch alloc] initWithFrame:self.switchBGView.bounds];
    switch0.style = ZJSwitchStyleNoBorder;
    switch0.onText = @"接单";
    switch0.offText = @"不接单";
    [switch0 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    [self.switchBGView addSubview:switch0];
    
}
- (IBAction)settingAction:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:settingVC animated:YES];
}

- (IBAction)turnoverAction:(id)sender {
    TurnoverViewController *turnoverVC = [[TurnoverViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:turnoverVC animated:YES];
}

- (IBAction)settingPayAction:(id)sender {
    paymentAccountSettingViewController *payAccountVC = [[paymentAccountSettingViewController alloc] init];
    [self.parentViewController.navigationController pushViewController:payAccountVC animated:YES];
}

- (IBAction)serviceCenterAction:(id)sender {
    ServiceCenterViewController *serviceCenterVC = [[ServiceCenterViewController alloc] init];
    serviceCenterVC.titleStr = @"客服中心";
    [self.parentViewController.navigationController pushViewController:serviceCenterVC animated:YES];
}

- (IBAction)markettingManagerAction:(id)sender {
    ServiceCenterViewController *serviceCenterVC = [[ServiceCenterViewController alloc] init];
    serviceCenterVC.titleStr = @"市场经理";
    [self.parentViewController.navigationController pushViewController:serviceCenterVC animated:YES];
}

- (IBAction)aboutUsAction:(id)sender {
    AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
    [self.parentViewController.navigationController pushViewController:aboutUsVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)handleSwitchEvent:(ZJSwitch *)switchView {
    
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
