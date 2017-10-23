//
//  HomeTableviewCellTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "HomeTableviewCellTableViewCell.h"
#import "JSSHDishModel.h"


@interface HomeTableviewCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dishnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishpriceLabel;

@end

@implementation HomeTableviewCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDishModel:(JSSHDishModel *)dishModel {
    _dishModel = dishModel;
    _dishnameLabel.text = _dishModel.name;
    _dishcountLabel.text = [NSString stringWithFormat:@"%ld",_dishModel.count];
    _dishpriceLabel.text = [NSString stringWithFormat:@"%@",_dishModel.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
