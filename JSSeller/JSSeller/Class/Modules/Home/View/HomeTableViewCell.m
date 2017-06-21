//
//  HomeTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeTableviewCellTableViewCell.h"

@interface HomeTableViewCell ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self registUI];
}

- (void)registUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableviewCellTableViewCell" bundle:nil]  forCellReuseIdentifier:@"HomeTableviewCellTableViewCell"];
}

- (void)setType:(HomeTableViewCellType)type {
    _type = type;
    switch (_type) {
        case HomeTableViewCellTypeAwait:
            _typeLabel.text = @"待接单";
            _typeLabel.textColor = RGB(120, 120, 120);
            [_myButton setTitle:@"确定接单" forState:(UIControlStateNormal)];
            break;
        case HomeTableViewCellTypeAccept:
            _typeLabel.text = @"已接单";
            _typeLabel.textColor = RGB(120, 120, 120);
            [_myButton setTitle:@"确定接单" forState:(UIControlStateNormal)];
            break;
        case HomeTableViewCellTypeComplete:
            _typeLabel.text = @"已完成";
            _typeLabel.textColor = RGB(120, 120, 120);
            [_myButton setTitle:@"确定接单" forState:(UIControlStateNormal)];
            break;
        case HomeTableViewCellTypeException:
            _typeLabel.textColor = [UIColor redColor];
            _typeLabel.text = @"已取消";
            [_myButton setTitle:@"退款" forState:(UIControlStateNormal)];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableviewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableviewCellTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
