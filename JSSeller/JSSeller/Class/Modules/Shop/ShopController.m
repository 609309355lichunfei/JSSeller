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
#import "JSSHUserModel.h"
#import "JSLoginViewController.h"
#import "ShopEditViewController.h"

@interface ShopController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *switchBGView;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoverTodayLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyturnoverLabel;

@property (strong, nonatomic) ZJSwitch *switch0;


@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([JSRequestManager sharedManager].userName == nil || [JSRequestManager sharedManager].userName.length == 0) {
        self.shopNameLabel.text = @"登录/注册";
        [self.shopLogoImageView setImage:[UIImage imageNamed:@"店铺中心默认头像"]];
    }else {
//        [[JSRequestManager sharedManager] getMemberInfoSuccess:^(id responseObject) {
//            [[JSYHUserModel defaultModel] setValuesForKeysWithDictionary:responseObject[@"data"]];
//            [self.iconimage setImageWithURL:[NSURL URLWithString:[JSYHUserModel defaultModel].logo] placeholder:nil];
//            self.userNameLabel.text = [JSYHUserModel defaultModel].nickname;
//        } Failed:^(NSError *error) {
//            
//        }];
        [[JSRequestManager sharedManager] getInfoWithSuccess:^(id responseObject) {
            [[JSSHUserModel defaultModel] setValuesForKeysWithDictionary:responseObject[@"data"]];
            [self.shopLogoImageView setImageWithURL:[NSURL URLWithString:[JSSHUserModel defaultModel].logo] placeholder:[UIImage imageNamed:@"店铺中心默认头像"]];
            self.shopNameLabel.text = [JSSHUserModel defaultModel].shopname;
            self.turnoverTodayLabel.text = [NSString stringWithFormat:@"%@",[JSSHUserModel defaultModel].today_income];
            self.historyturnoverLabel.text = [NSString stringWithFormat:@"%@",[JSSHUserModel defaultModel].month_income];
            self.switch0.on = [JSSHUserModel defaultModel].is_open == 1 ? YES : NO;
        } Failed:^(NSError *error) {
            
        }];
    }
    
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
    
    self.shopLogoImageView.layer.cornerRadius = 40;
    
    self.switch0 = [[ZJSwitch alloc] initWithFrame:self.switchBGView.bounds];
    _switch0.style = ZJSwitchStyleNoBorder;
    _switch0.onText = @"接单";
    _switch0.offText = @"不接单";
    [_switch0 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    [self.switchBGView addSubview:_switch0];
    
}

- (IBAction)shopinfoAction:(id)sender {
    if ([self.shopNameLabel.text isEqualToString:@"登录/注册"]) {
        JSLoginViewController *loginVC = [[JSLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:^{
        }];
    } else {
        ShopEditViewController *shopEditVC = [[ShopEditViewController alloc]init];
        [self.parentViewController.navigationController pushViewController:shopEditVC animated:YES];
    }
}


- (IBAction)settingAction:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:settingVC animated:YES];
}

- (IBAction)turnoverAction:(id)sender {
//    TurnoverViewController *turnoverVC = [[TurnoverViewController alloc]init];
//    [self.parentViewController.navigationController pushViewController:turnoverVC animated:YES];
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
    [JSSHUserModel defaultModel].is_open = switchView.isOn ? 1 : 0;
    [[JSRequestManager sharedManager] putInfoWithUserModel:[JSSHUserModel defaultModel] data:nil Success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
    
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
        
        [[JSRequestManager sharedManager] getInfoWithSuccess:^(id responseObject) {
            [[JSSHUserModel defaultModel] setValuesForKeysWithDictionary:responseObject[@"data"]];
            [self.shopLogoImageView setImageWithURL:[NSURL URLWithString:[JSSHUserModel defaultModel].logo] placeholder:[UIImage imageNamed:@"店铺中心默认头像"]];
            self.shopNameLabel.text = [JSSHUserModel defaultModel].shopname;
            self.turnoverTodayLabel.text = [NSString stringWithFormat:@"%@",[JSSHUserModel defaultModel].today_income];
            self.historyturnoverLabel.text = [NSString stringWithFormat:@"%@",[JSSHUserModel defaultModel].month_income];
            self.switch0.on = [JSSHUserModel defaultModel].is_open == 1 ? YES : NO;
        } Failed:^(NSError *error) {
        }];
        
    } Failed:^(NSError *error) {
        
    }];
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
