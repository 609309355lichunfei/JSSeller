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

@interface ShopController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //  毛玻璃view 视图
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    //添加到要有毛玻璃特效的控件中
    
    effectView.frame = self.backgroundImageView.bounds;
    
    [self.backgroundImageView addSubview:effectView];
}
- (IBAction)settingAction:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:settingVC animated:YES];
}

- (IBAction)turnoverAction:(id)sender {
    TurnoverViewController *turnoverVC = [[TurnoverViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:turnoverVC animated:YES];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
