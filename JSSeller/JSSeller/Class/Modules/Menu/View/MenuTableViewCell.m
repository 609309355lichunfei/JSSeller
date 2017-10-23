//
//  MenuTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "JSSHDishModel.h"
#import "BorderLineButton.h"
#import "AddFoodViewController.h"

@interface MenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet BorderLineButton *sellOutBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *soldOutBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *editBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *deleteBT;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statuImageView;


@end

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)sellOutAction:(id)sender {
    
}

- (IBAction)soldOut:(id)sender {
    _dishModel.is_sale = _dishModel.is_sale == 0 ? 1 : 0;
    [[JSRequestManager sharedManager] putDishWithDishModel:_dishModel Success:^(id responseObject) {
        [self setDishModel:_dishModel];
    } Failed:^(NSError *error) {
        [AppManager showToastWithMsg:@"失败"];
    }];
    
}

- (IBAction)editAction:(id)sender {
    AddFoodViewController *addfoodVC = [[AddFoodViewController alloc] init];
    addfoodVC.dishModel = _dishModel;
    [self.viewController.parentViewController.navigationController pushViewController:addfoodVC animated:YES];
}

- (IBAction)deleteAction:(id)sender {
    UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"确定要删除分类" message:[NSString stringWithFormat:@"%@?",_dishModel.name] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.deleteBlock(_dishModel);
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [deleteAlert addAction: deleteAction];
    [deleteAlert addAction:cancelAction];
    [self.viewController presentViewController:deleteAlert animated:YES completion:nil];
}

- (void)setDishModel:(JSSHDishModel *)dishModel {
    _dishModel = dishModel;
    self.editView.hidden = !_dishModel.option;
    self.arrowImageView.highlighted = !self.editView.hidden;
    self.dishNameLabel.text = _dishModel.name;
    if (_dishModel.is_sale == 0) {
        self.statuImageView.image = [UIImage imageNamed:@"已下架"];
        [self.soldOutBT setTitle:@"上架" forState:(UIControlStateNormal)];
    } else {
        self.statuImageView.image = nil;
        [self.soldOutBT setTitle:@"下架" forState:(UIControlStateNormal)];
    }
    [self.logoImageView setImageWithURL:[NSURL URLWithString:_dishModel.logo] placeholder:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
