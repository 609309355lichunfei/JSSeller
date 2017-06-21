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

@property (assign, nonatomic) HomeTableViewCellType type;

@property (strong, nonatomic) UIButton *currentBT;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    _currentBT = _xinBT;
    _type = HomeTableViewCellTypeAwait;
}

- (IBAction)newIndentAction:(id)sender {
    if (_currentBT == _xinBT) {
        return;
    }
    _type = HomeTableViewCellTypeAwait;
    [_currentBT setTitleColor:RGB(120, 120, 120) forState:(UIControlStateNormal)];
    _currentBT = _xinBT;
    [_currentBT setTitleColor:RGB(253, 150, 31) forState:(UIControlStateNormal)];
    [self.tableView reloadData];

}

- (IBAction)acceptedIndentAction:(id)sender {
    if (_currentBT == _acceptedBT) {
        return;
    }
    _type = HomeTableViewCellTypeAccept;
    [_currentBT setTitleColor:RGB(120, 120, 120) forState:(UIControlStateNormal)];
    _currentBT = _acceptedBT;
    [_currentBT setTitleColor:RGB(253, 150, 31) forState:(UIControlStateNormal)];
    [self.tableView reloadData];

}

- (IBAction)completeIndentAction:(id)sender {
    if (_currentBT == _completedBT) {
        return;
    }
    _type = HomeTableViewCellTypeComplete;
    [_currentBT setTitleColor:RGB(120, 120, 120) forState:(UIControlStateNormal)];
    _currentBT = _completedBT;
    [_currentBT setTitleColor:RGB(253, 150, 31) forState:(UIControlStateNormal)];
    [self.tableView reloadData];
}

- (IBAction)exceptionIndentAction:(id)sender {
    if (_currentBT == _exceptionBT) {
        return;
    }
    _type = HomeTableViewCellTypeException;
    [_currentBT setTitleColor:RGB(120, 120, 120) forState:(UIControlStateNormal)];
    _currentBT = _exceptionBT;
    [_currentBT setTitleColor:RGB(253, 150, 31) forState:(UIControlStateNormal)];
    [self.tableView reloadData];

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
