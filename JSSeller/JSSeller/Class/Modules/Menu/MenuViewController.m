//
//  MenuViewController.m
//  YYSeller
//
//  Created by 李春菲 on 17/6/16.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "MenuTableViewHeaderView.h"
#import "MenuModel.h"
#import "ClassifyControlViewController.h"
#import "AddFoodViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isHidden;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
    for (int i = 0; i < 3; i ++) {
        MenuModel *model = [[MenuModel alloc]init];
        model.option = NO;
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    _isHidden = YES;
}
- (IBAction)classifyControllAction:(id)sender {
    ClassifyControlViewController *classifyControlVC = [[ClassifyControlViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:classifyControlVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuModel *model = self.dataArray[indexPath.row];
    if (model.option) {
        return 90;
    } else {
        return 50;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MenuModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MenuTableViewHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"MenuTableViewHeaderView" owner:self options:nil]lastObject];
    MJWeakSelf;
    view.addBlock = ^(){
        AddFoodViewController *addFoodVC = [[AddFoodViewController alloc]init];
        [weakSelf.parentViewController.navigationController pushViewController:addFoodVC animated:YES];
    };
    return view;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuModel *model = self.dataArray[indexPath.row];
    model.option = !model.option;
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:(UITableViewRowAnimationFade)];
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
