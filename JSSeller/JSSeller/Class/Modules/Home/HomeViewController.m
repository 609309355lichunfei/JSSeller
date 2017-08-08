//
//  HomeViewController.m
//  YYSeller
//
//  Created by 李春菲 on 17/6/16.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *xinBT;
@property (weak, nonatomic) IBOutlet UIButton *acceptedBT;
@property (weak, nonatomic) IBOutlet UIButton *completedBT;
@property (weak, nonatomic) IBOutlet UIButton *exceptionBT;

@property (strong, nonatomic) UIView *signView;

@property (assign, nonatomic) HomeTableViewCellType type;

@property (strong, nonatomic) UIButton *currentBT;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)viewDidLayoutSubviews {
    NSInteger signViewWidth = 50;
    if (_currentBT == _exceptionBT) {
        signViewWidth = 65;
    }
    self.signView.width = signViewWidth;
    self.signView.center = CGPointMake(self.currentBT.centerX, self.currentBT.centerY + 10);
    
}

- (void)registUI {
    self.signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 2)];
    self.signView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    _currentBT = _xinBT;
    _type = HomeTableViewCellTypeAwait;
}

- (IBAction)newIndentAction:(id)sender {
    if (_currentBT == _xinBT) {
        return;
    }
    _type = HomeTableViewCellTypeAwait;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _xinBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.tableView reloadData];

}

- (IBAction)acceptedIndentAction:(id)sender {
    if (_currentBT == _acceptedBT) {
        return;
    }
    _type = HomeTableViewCellTypeAccept;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _acceptedBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.tableView reloadData];

}

- (IBAction)completeIndentAction:(id)sender {
    if (_currentBT == _completedBT) {
        return;
    }
    _type = HomeTableViewCellTypeComplete;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _completedBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.tableView reloadData];
}

- (IBAction)exceptionIndentAction:(id)sender {
    if (_currentBT == _exceptionBT) {
        return;
    }
    _type = HomeTableViewCellTypeException;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _exceptionBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.tableView reloadData];

}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 413.5;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    cell.type = _type;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
