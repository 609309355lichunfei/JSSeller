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
