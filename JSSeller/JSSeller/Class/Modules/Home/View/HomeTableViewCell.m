//
//  HomeTableViewCell.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeTableviewCellTableViewCell.h"
#import "JSSHOrderModel.h"

@interface HomeTableViewCell ()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger _time;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *useraddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarksLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordertimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btHeight;
@property (weak, nonatomic) IBOutlet UIImageView *timerImageView;


@property (strong, nonatomic) NSTimer *timer;


@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self registUI];
}

- (void)registUI {
    self.myButton.layer.borderWidth = 0;
    self.myButton.layer.cornerRadius = 5;
    self.myButton.clipsToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableviewCellTableViewCell" bundle:nil]  forCellReuseIdentifier:@"HomeTableviewCellTableViewCell"];
}

- (void)resetCellUI {
    self.remarksLabel.text = @"";
    self.btHeight.constant = 40;
}

- (IBAction)phoneAction:(id)sender {
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"是否要联系客人?" message:[NSString stringWithFormat:@"%@",self.orderModel.phone] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString *allString = [NSString stringWithFormat:@"tel:%@",_orderModel.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alerVC addAction:action];
    [alerVC addAction:cancelAction];
    [self.viewController presentViewController:alerVC animated:YES completion:nil];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"确定接单"]) {
        UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"确定接单?" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [[JSRequestManager sharedManager] acceptOrderWithOderno:_orderModel.order_no Success:^(id responseObject) {
                _btactionBlock();
            } Failed:^(NSError *error) {
                [AppManager showToastWithMsg:@"网络似乎有点波动,请稍后再试"];
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alerVC addAction:action];
        [alerVC addAction:cancelAction];
        [self.viewController presentViewController:alerVC animated:YES completion:nil];
    } else if ([sender.currentTitle isEqualToString:@"完成菜品"]) {
        UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"确定完成菜品?" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [[JSRequestManager sharedManager] cookfinishWithOrderno:_orderModel.order_no Success:^(id responseObject) {
                _btactionBlock();
            } Failed:^(NSError *error) {
                [AppManager showToastWithMsg:@"网络似乎有点波动,请稍后再试"];
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alerVC addAction:action];
        [alerVC addAction:cancelAction];
        [self.viewController presentViewController:alerVC animated:YES completion:nil];
        
    }
}


- (void)setType:(HomeTableViewCellType)type {
    _type = type;
    switch (_type) {
        case HomeTableViewCellTypeAwait:
//            _typeLabel.text = @"待接单";
            self.btHeight.constant = 40;
            [_myButton setTitle:@"确定接单" forState:(UIControlStateNormal)];
            break;
        case HomeTableViewCellTypeAccept:
//            _typeLabel.text = @"已接单";
            self.btHeight.constant = 40;
            [_myButton setTitle:@"完成菜品" forState:(UIControlStateNormal)];
            break;
        case HomeTableViewCellTypeComplete:
//            _typeLabel.text = @"已完成";
//            [_myButton setTitle:@"确定接单" forState:(UIControlStateNormal)];
            self.btHeight.constant = 0;
            break;
        case HomeTableViewCellTypeException:
//            _typeLabel.text = @"已取消";
            
            self.btHeight.constant = 0;
//            [_myButton setTitle:@"退款" forState:(UIControlStateNormal)];
            break;
            
        default:
            break;
    }
}

- (void)setOrderModel:(JSSHOrderModel *)orderModel {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _orderModel = orderModel;
    self.usernameLabel.text = _orderModel.username;
    self.userphoneLabel.text = _orderModel.phone;
    self.useraddressLabel.text = [NSString stringWithFormat:@"%@%@",_orderModel.address,_orderModel.addressdet];
    self.numberLabel.text = [NSString stringWithFormat:@"#%@",_orderModel.order_no];
    self.ordertimeLabel.text = [AppManager timestampSwitchTime:_orderModel.paytime];
    self.remarksLabel.text = _orderModel.remark;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",_orderModel.lastprice];
    switch (_orderModel.status) {
        case 1:
            
            _typeLabel.text = @"待接单";
            if (300 > _orderModel.nowtime - _orderModel.paytime) {
                self.timeLabel.hidden = NO;
                self.timerImageView.hidden = NO;
                _time = 300 - ([AppManager getNowTimestamp] + [UserManager sharedManager].timerinterval - _orderModel.paytime) + 10;
                NSString *minute = [NSString stringWithFormat:@"%ld",_time / 60];
                if (_time % 60 > 9) {
                    NSString *second = [NSString stringWithFormat:@"%ld",_time % 60];
                    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",minute,second];
                } else {
                    NSString *second = [NSString stringWithFormat:@"0%ld",_time % 60];
                    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",minute,second];
                }
                self.timer = [NSTimer timerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
                    _time --;
                    if (_time == 0) {
                        _time = 0;
                        self.btactionBlock();
                    }
                    NSString *minute = [NSString stringWithFormat:@"%ld",_time / 60];
                    if (_time % 60 > 9) {
                        NSString *second = [NSString stringWithFormat:@"%ld",_time % 60];
                        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",minute,second];
                    } else {
                        NSString *second = [NSString stringWithFormat:@"0%ld",_time % 60];
                        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",minute,second];
                    }
                    
                } repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:(NSRunLoopCommonModes)];
                
                
            } else {
                self.timerImageView.hidden = YES;
                self.timeLabel.hidden = YES;
            }
            break;
        case 2:
            _typeLabel.text = @"已接单";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        case 3:
            _typeLabel.text = @"已完成";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        case 4:
            _typeLabel.text = @"骑手取到菜";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        case 10:
            _typeLabel.text = @"已送达";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        case 11:
            _typeLabel.text = @"超时";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        case 12:
            _typeLabel.text = @"已取消";
            self.timerImageView.hidden = YES;
            self.timeLabel.hidden = YES;
            break;
        default:
            break;
    }
    self.dataArray = _orderModel.dishs;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableviewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableviewCellTableViewCell" forIndexPath:indexPath];
    JSSHDishModel *model = self.dataArray[indexPath.row];
    cell.dishModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
