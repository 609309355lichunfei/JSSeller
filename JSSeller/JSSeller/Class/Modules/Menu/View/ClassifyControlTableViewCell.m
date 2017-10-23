//
//  ClassifyControlTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ClassifyControlTableViewCell.h"
#import "JSSHCateModel.h"

@interface ClassifyControlTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *optionVIew;
@property (weak, nonatomic) IBOutlet UIImageView *optionImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation ClassifyControlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(JSSHCateModel *)model {
    _model = model;
    self.nameTF.text = _model.cate;
    self.optionVIew.hidden = !_model.option;
    self.nameTF.enabled = _model.isEdit;
    self.doneBT.hidden = !_model.isEdit;
    if (_model.isEdit) {
        [_nameTF becomeFirstResponder];
    }
}

- (IBAction)editAction:(id)sender {
    _model.isEdit = YES;
    self.nameTF.enabled = YES;
    self.doneBT.hidden = NO;
    [self.nameTF becomeFirstResponder];
}

- (IBAction)deleteAction:(id)sender {
    UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"确定要删除分类" message:[NSString stringWithFormat:@"%@?",_model.cate] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.deleteBlock(_model);
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [deleteAlert addAction: deleteAction];
    [deleteAlert addAction:cancelAction];
    [self.viewController presentViewController:deleteAlert animated:YES completion:nil];
}

- (IBAction)doneAction:(id)sender {
    NSString *cateName = _nameTF.text;
    _model.cate = cateName;
    if (cateName.length > 0) {
        self.doneBlock(_model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
