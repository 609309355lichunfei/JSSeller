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

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *menuManageBT;
@property (weak, nonatomic) IBOutlet UIButton *indentManageBT;
@property (weak, nonatomic) IBOutlet UIButton *storeCenterBT;
@property (strong, nonatomic) UIButton *currentBT;
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

- (void)registUI {
    self.homeVC = [[HomeViewController alloc]init];
    [self addChildViewController:self.homeVC];
    self.homeVC.view.frame = self.mainView.bounds;
    [self.mainView addSubview:self.homeVC.view];
    self.currentVC = self.homeVC;
    self.currentBT = self.indentManageBT;
    
    self.menuVC = [[MenuViewController alloc]init];
    self.shopVC = [[ShopController alloc]init];
}

- (IBAction)menuManagerAction:(id)sender {
    if (_currentBT == self.menuManageBT) {
        return;
    }
    [_currentBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _currentBT = self.menuManageBT;
    [_currentBT setTitleColor:RGB(254, 227, 10) forState:(UIControlStateNormal)];
    [self replaceController:_currentVC newController:self.menuVC];
}

- (IBAction)indentManageAction:(id)sender {
    if (_currentBT == self.indentManageBT) {
        return;
    }
    [_currentBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _currentBT = self.indentManageBT;
    [_currentBT setTitleColor:RGB(254, 227, 10) forState:(UIControlStateNormal)];
    [self replaceController:_currentVC newController:self.homeVC];
}

- (IBAction)storeCender:(id)sender {
    if (_currentBT == self.storeCenterBT) {
        return;
    }
    [_currentBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _currentBT = self.storeCenterBT;
    [_currentBT setTitleColor:RGB(254, 227, 10) forState:(UIControlStateNormal)];
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
