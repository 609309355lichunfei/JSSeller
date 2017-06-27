//
//  TurnoverViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "TurnoverViewController.h"
#import "TurnoverTableViewCell.h"

@interface TurnoverViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *changeTitleSelectView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *changeYearView;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation TurnoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"TurnoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"TurnoverTableViewCell"];
}

- (IBAction)changeTitleAction:(id)sender {
    _changeTitleSelectView.hidden = !_changeTitleSelectView.isHidden;

}

- (IBAction)changeYearsAction:(id)sender {
    
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)todayTurnoverAction:(id)sender {
    self.changeTitleSelectView.hidden = YES;
    if ([self.titleLabel.text isEqualToString:@"今日营业额"]) {
        return;
    }
    self.titleLabel.text = @"今日营业额";
    self.todayTitleLabel.text = @"今日营业额:";
    self.changeYearView.hidden = YES;
}
- (IBAction)weakTurnoverAction:(id)sender {
    self.changeTitleSelectView.hidden = YES;
    if ([self.titleLabel.text isEqualToString:@"本周营业额"]) {
        return;
    }
    self.titleLabel.text = @"本周营业额";
    self.todayTitleLabel.text = @"今日营业额:";
    self.changeYearView.hidden = YES;
}
- (IBAction)monthTurnoverAction:(id)sender {
    self.changeTitleSelectView.hidden = YES;
    if ([self.titleLabel.text isEqualToString:@"本月营业额"]) {
        return;
    }
    self.titleLabel.text = @"本月营业额";
    self.todayTitleLabel.text = @"今日营业额:";
    self.changeYearView.hidden = YES;
}
- (IBAction)totalTapAction:(id)sender {
    self.changeTitleSelectView.hidden = YES;
    if ([self.titleLabel.text isEqualToString:@"总营业额"]) {
        return;
    }
    self.titleLabel.text = @"总营业额";
    self.todayTitleLabel.text = @"历史营业额:";
    self.changeYearView.hidden = NO;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 290;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TurnoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TurnoverTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
