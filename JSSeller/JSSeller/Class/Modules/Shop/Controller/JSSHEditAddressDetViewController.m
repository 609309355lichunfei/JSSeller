//
//  JSSHEditAddressDetViewController.m
//  JSSeller
//
//  Created by 吴頔 on 2017/10/8.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHEditAddressDetViewController.h"

@interface JSSHEditAddressDetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addressDetTextField;

@end

@implementation JSSHEditAddressDetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.addressDetTextField.text = self.addressDetLabel.text;
}
- (IBAction)saveAction:(id)sender {
    self.addressDetLabel.text = self.addressDetTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender {
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
