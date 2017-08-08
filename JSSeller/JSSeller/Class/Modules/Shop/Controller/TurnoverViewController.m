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
@property (weak, nonatomic) IBOutlet UILabel *weakCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *weakTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yearViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateChooseViewHeight;


@property (strong, nonatomic) UILabel *currentCountLabel;
@property (strong, nonatomic) UILabel *currentTitleLabel;

@end

@implementation TurnoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"TurnoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"TurnoverTableViewCell"];
    _currentCountLabel = self.weakCountLabel;
    _currentTitleLabel = self.weakTitleLabel;
    self.dateChooseViewHeight.constant = 0;
    self.yearViewWidth.constant = KScreenWidth / 3;
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)weakTurnoverAction:(id)sender {
    if (_currentCountLabel == self.weakCountLabel) {
        return;
    }
    self.dateChooseViewHeight.constant = 0;
    _currentCountLabel.textColor = UIColorFromRGB(0x333333);
    _currentTitleLabel.textColor = UIColorFromRGB(0x666666);
    _currentCountLabel = self.weakCountLabel;
    _currentTitleLabel = self.weakTitleLabel;
    _currentCountLabel.textColor = UIColorFromRGB(0x0490e6);
    _currentTitleLabel.textColor = UIColorFromRGB(0x0490e6);
}

- (IBAction)monthTurnoverAction:(id)sender {
    if (_currentCountLabel == self.monthCountLabel) {
        return;
    }
    self.dateChooseViewHeight.constant = 50;
    self.yearViewWidth.constant = 0;
    _currentCountLabel.textColor = UIColorFromRGB(0x333333);
    _currentTitleLabel.textColor = UIColorFromRGB(0x666666);
    _currentCountLabel = self.monthCountLabel;
    _currentTitleLabel = self.monthTitleLabel;
    _currentCountLabel.textColor = UIColorFromRGB(0x0490e6);
    _currentTitleLabel.textColor = UIColorFromRGB(0x0490e6);
}

- (IBAction)totalTapAction:(id)sender {
    if (_currentCountLabel == self.yearCountLabel) {
        return;
    }
    self.dateChooseViewHeight.constant = 50;
    self.yearViewWidth.constant = KScreenWidth / 3;
    _currentCountLabel.textColor = UIColorFromRGB(0x333333);
    _currentTitleLabel.textColor = UIColorFromRGB(0x666666);
    _currentCountLabel = self.yearCountLabel;
    _currentTitleLabel = self.yearTitleLabel;
    _currentCountLabel.textColor = UIColorFromRGB(0x0490e6);
    _currentTitleLabel.textColor = UIColorFromRGB(0x0490e6);
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 264;
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
