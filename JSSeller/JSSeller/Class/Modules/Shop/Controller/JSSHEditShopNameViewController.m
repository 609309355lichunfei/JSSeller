//
//  JSSHEditShopNameViewController.m
//  JSSeller
//
//  Created by 吴頔 on 2017/10/3.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHEditShopNameViewController.h"

@interface JSSHEditShopNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;

@end

@implementation JSSHEditShopNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.shopNameTextField.text = self.shopNameLabel.text;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)saveAction:(id)sender {
    self.shopNameLabel.text = self.shopNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
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
