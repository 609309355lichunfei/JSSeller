//
//  BankCardBindingViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "BankCardBindingViewController.h"
#import "BankTableViewCell.h"

@interface BankCardBindingViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankTableViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *bankNameField;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *verificationBT;
@property (weak, nonatomic) IBOutlet UIButton *doneBT;

@end

@implementation BankCardBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    self.doneBT.layer.cornerRadius = 5;
    self.doneBT.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"BankTableViewCell" bundle:nil] forCellReuseIdentifier:@"BankTableViewCell"];
    self.dataArray = [@[@"中国银行",@"中国建设银行",@"中国农业银行",@"招商银行",@"民生银行"] mutableCopy];
    [self.tableView reloadData];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseBankAction:(id)sender {
    if (self.bankTableViewHeight.constant == 0) {
        self.bankTableViewHeight.constant = 250;
        [self.tableView reloadData];
    } else {
        self.bankTableViewHeight.constant = 0;
    }
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bankNameLabel.text = self.dataArray[indexPath.row];
    if ([_bankNameField.text isEqualToString:self.dataArray[indexPath.row]]) {
        cell.selectImageView.image = [UIImage imageNamed:@"勾选-"];
    } else {
        cell.selectImageView.image = [UIImage imageNamed:@"未勾选-"];
    }
    return cell;
}

#pragma mark - TableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.bankNameField.text = self.dataArray[indexPath.row];
    self.bankTableViewHeight.constant = 0;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * phoneRegex = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isMatch = [regextestct evaluateWithObject:[textField.text stringByAppendingString:string]];
    if (isMatch) {
        [self.verificationBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.verificationBT.backgroundColor = UIColorFromRGB(0x0490e6);
        self.verificationBT.enabled = YES;
    } else {
        [self.verificationBT setTitleColor:UIColorFromRGB(0xa2a2a2) forState:(UIControlStateNormal)];
        self.verificationBT.backgroundColor = UIColorFromRGB(0xcccccc);
        self.verificationBT.enabled = NO;
    }
    NSLog(@"textfield.text = %@ string = %@",textField.text,string);
    
    return YES;
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
