//
//  AddFoodViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "AddFoodViewController.h"
#import "AJImageheadData.h"
#import "JSSHDishModel.h"

@interface AddFoodViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property (weak, nonatomic) IBOutlet UITextField *dishNameTF;
@property (weak, nonatomic) IBOutlet UITextField *dishpriceTF;
@property (weak, nonatomic) IBOutlet UITextView *dishinfoTextView;
@property (weak, nonatomic) IBOutlet UITextField *dishfinishtimeTF;
@property (weak, nonatomic) IBOutlet UIButton *doneBT;
@property (weak, nonatomic) IBOutlet UIImageView *dishlogoImageView;

@property (strong, nonatomic) NSData *logoData;

@end

@implementation AddFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    self.doneBT.layer.cornerRadius = 5;
    [self.dishlogoImageView setImageWithURL:[NSURL URLWithString:_dishModel.logo] placeholder:nil];
    self.dishNameTF.text = _dishModel.name;
    self.dishpriceTF.text = _dishModel.price.stringValue;
    self.dishinfoTextView.text = _dishModel.info;
    if (_dishModel != nil) {
        self.addImageView.hidden = YES;
    }
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addImageAction:(id)sender {
    [[AJImageheadData  shareInstance] showActionSheetInView:self.view fromController:self completion:^(UIImage *image, NSData *iamgeData) {
        self.addImageView.hidden = YES;
        self.dishlogoImageView.image = image;
        self.logoData = iamgeData;
    } cancelBlock:^{
    }];
}


- (IBAction)doneAction:(id)sender {
    if (self.dishlogoImageView.image == nil) {
        [AppManager showToastWithMsg:@"请添加菜品图片"];
        return;
    }
    if (self.dishNameTF.text.length == 0 || self.dishNameTF.text == nil) {
        [AppManager showToastWithMsg:@"请填写菜品名称"];
        return;
    }
    if (self.dishpriceTF.text.length == 0 || self.dishpriceTF.text == nil) {
        [AppManager showToastWithMsg:@"请填写菜品价格"];
        return;
    }
    if (self.dishinfoTextView.text.length == 0 || self.dishpriceTF.text == nil) {
        [AppManager showToastWithMsg:@"请填写菜品介绍"];
        return;
    }
    if (self.dishfinishtimeTF.text.length == 0 || self.dishpriceTF.text == 0) {
        [AppManager showToastWithMsg:@"请填写菜品预计结束时间"];
        return;
    }
    [MBProgressHUD showMessage:@"上传中"];
    JSSHDishModel *dishModel = [[JSSHDishModel alloc] init];
    dishModel.name = self.dishNameTF.text;
    dishModel.cateid = _cateid;
    if (_cateid == nil) {
        dishModel.cateid = _dishModel.cateid;
    }
    dishModel.price = [NSNumber numberWithInteger:[self.dishpriceTF.text integerValue] * 100];
    dishModel.info = self.dishinfoTextView.text;
    dishModel.finishtimeStr = self.dishfinishtimeTF.text;
    if (_cateid == nil) {
        dishModel.is_sale = _dishModel.is_sale;
        dishModel.finishtime = _dishModel.finishtime;
        dishModel.dishid = _dishModel.dishid;
        [[JSRequestManager sharedManager] putDishWithDishModel:dishModel data:self.logoData Success:^(id responseObject) {
            [MBProgressHUD hideHUD];
            [AppManager showToastWithMsg:@"上传成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } Failed:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [AppManager showToastWithMsg:@"上传失败"];
        }];
        
    } else {
        
    [[JSRequestManager sharedManager] postDishWithDishModel:dishModel image:self.dishlogoImageView.image Success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [AppManager showToastWithMsg:@"上传成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } Failed:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [AppManager showToastWithMsg:@"上传失败"];
    }];
    }
    
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
