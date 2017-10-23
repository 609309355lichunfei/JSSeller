//
//  ServiceCenterViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/7/12.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ServiceCenterViewController.h"

@interface ServiceCenterViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;

@end

@implementation ServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleItem.title = _titleStr;
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)phoneAction:(id)sender {
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"是否要联系客服?" message:@"0574-87566681" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString *allString = [NSString stringWithFormat:@"tel:0574-87566681"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alerVC addAction:action];
    [alerVC addAction:cancelAction];
    [self presentViewController:alerVC animated:YES completion:nil];
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
