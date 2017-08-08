//
//  JSLoginViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/7/17.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSLoginViewController.h"
#import "JSPassWordViewController.h"

@interface JSLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginBGView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *loginBT;

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
}

- (IBAction)loginAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgetPasswordAction:(id)sender {
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
