//
//  MenuTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "MenuModel.h"

@interface MenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *editView;

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
