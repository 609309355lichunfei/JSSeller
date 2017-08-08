//
//  MenuTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "MenuModel.h"
#import "BorderLineButton.h"

@interface MenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet BorderLineButton *sellOutBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *soldOutBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *editBT;
@property (weak, nonatomic) IBOutlet BorderLineButton *deleteBT;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)sellOutAction:(id)sender {
    
}

- (IBAction)soldOut:(id)sender {
    
}

- (IBAction)editAction:(id)sender {
    
}

- (IBAction)deleteAction:(id)sender {
    
}

- (void)setModel:(MenuModel *)model {
    _model = model;
    self.editView.hidden = !_model.option;
    self.arrowImageView.highlighted = !self.editView.hidden;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
