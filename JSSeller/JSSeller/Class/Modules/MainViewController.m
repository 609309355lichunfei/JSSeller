//
//  MainViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MainViewController.h"
#import "ShopController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "JSLoginViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *menuManageBT;
@property (weak, nonatomic) IBOutlet UIImageView *menuManageImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuManageLabel;
@property (weak, nonatomic) IBOutlet UIButton *indentManageBT;
@property (weak, nonatomic) IBOutlet UIImageView *indentManageImageView;
@property (weak, nonatomic) IBOutlet UILabel *indentManageLabel;
@property (weak, nonatomic) IBOutlet UIButton *storeCenterBT;
@property (weak, nonatomic) IBOutlet UIImageView *storeCenterImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeCenterLabel;
@property (strong, nonatomic) UIButton *currentBT;
@property (strong, nonatomic) UIImageView *currentImageView;
@property (strong, nonatomic) UILabel *currentLabel;
@property (strong, nonatomic) UIViewController *currentVC;

@property (strong, nonatomic) HomeViewController *homeVC;
@property (strong, nonatomic) MenuViewController *menuVC;
@property (strong, nonatomic) ShopController *shopVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([JSRequestManager sharedManager].userName == nil || [JSRequestManager sharedManager].userName.length == 0) {
        JSLoginViewController *loginVC = [[JSLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)registUI {
    self.homeVC = [[HomeViewController alloc]init];
    [self addChildViewController:self.homeVC];
    self.homeVC.view.frame = self.mainView.bounds;
    [self.mainView addSubview:self.homeVC.view];
    self.currentVC = self.homeVC;
    self.currentBT = self.indentManageBT;
    self.currentImageView = self.indentManageImageView;
    self.currentLabel = self.indentManageLabel;
    self.currentImageView.highlighted = YES;
    
    self.menuVC = [[MenuViewController alloc]init];
    self.shopVC = [[ShopController alloc]init];
    
    if ([JSRequestManager sharedManager].token == nil || [JSRequestManager sharedManager].token.length == 0) {
        JSLoginViewController *loginVC = [[JSLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
    }
}

- (IBAction)menuManagerAction:(id)sender {
    if (_currentBT == self.menuManageBT) {
        return;
    }
    _currentImageView.highlighted = NO;
    _currentLabel.textColor = UIColorFromRGB(0x999999);
    _currentBT = self.menuManageBT;
    _currentImageView = self.menuManageImageView;
    _currentLabel = self.menuManageLabel;
    _currentImageView.highlighted = YES;
    _currentLabel.textColor = UIColorFromRGB(0x0795e7);
    [self replaceController:_currentVC newController:self.menuVC];
}

- (IBAction)indentManageAction:(id)sender {
    if (_currentBT == self.indentManageBT) {
        return;
    }
    _currentImageView.highlighted = NO;
    _currentLabel.textColor = UIColorFromRGB(0x999999);
    _currentBT = self.indentManageBT;
    _currentImageView = self.indentManageImageView;
    _currentLabel = self.indentManageLabel;
    _currentImageView.highlighted = YES;
    _currentLabel.textColor = UIColorFromRGB(0x0795e7);
    [self replaceController:_currentVC newController:self.homeVC];
}

- (IBAction)storeCender:(id)sender {
    if (_currentBT == self.storeCenterBT) {
        return;
    }
    _currentImageView.highlighted = NO;
    _currentLabel.textColor = UIColorFromRGB(0x999999);
    _currentBT = self.storeCenterBT;
    _currentImageView = self.storeCenterImageView;
    _currentLabel = self.storeCenterLabel;
    _currentImageView.highlighted = YES;
    _currentLabel.textColor = UIColorFromRGB(0x0795e7);
    [self replaceController:_currentVC newController:self.shopVC];
}

#pragma mark - 页面切换
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    CGRect rect = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    [self addChildViewController:newController];
    [newController didMoveToParentViewController:self];
    [oldController willMoveToParentViewController:nil];
    [oldController removeFromParentViewController];
    [oldController.view removeFromSuperview];
    newController.view.frame = rect;
    [_mainView  addSubview:newController.view];
    _currentVC = newController;
    [_mainView sendSubviewToBack:newController.view];
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
