//
//  ClassifyControlTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ClassifyControlTableViewCell.h"
#import "ClassfyModel.h"

@interface ClassifyControlTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *optionVIew;
@property (weak, nonatomic) IBOutlet UIImageView *optionImageView;

@end

@implementation ClassifyControlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ClassfyModel *)model {
    _model = model;
    self.optionVIew.hidden = !_model.option;
}

- (IBAction)editAction:(id)sender {
    
}

- (IBAction)deleteAction:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
