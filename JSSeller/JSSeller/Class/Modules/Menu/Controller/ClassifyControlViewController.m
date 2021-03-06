//
//  ClassifyControlViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ClassifyControlViewController.h"
#import "ClassifyControlTableViewCell.h"
#import "JSSHCateModel.h"

@interface ClassifyControlViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ClassifyControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassifyControlTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassifyControlTableViewCell"];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getConnectCate];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)getConnectCate {
    [[JSRequestManager sharedManager] getCatesWithSuccess:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.dataArray removeAllObjects];
        NSArray *cateDicArray = responseObject[@"data"][@"cates"];
        for (NSDictionary *cateDic in cateDicArray) {
            JSSHCateModel *cateModel = [[JSSHCateModel alloc] init];
            [cateModel setValuesForKeysWithDictionary:cateDic];
            [self.dataArray addObject:cateModel];
        }
        [self.tableView reloadData];
    } Failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addAction:(id)sender {
    JSSHCateModel *model = [[JSSHCateModel alloc]init];
    model.option = NO;
    model.isEdit = YES;
    model.isAdd = YES;
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSSHCateModel *model = self.dataArray[indexPath.row];
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
    ClassifyControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassifyControlTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JSSHCateModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.doneBlock = ^(JSSHCateModel *cateModel) {
        if (cateModel.isAdd) {
            [[JSRequestManager sharedManager] postCateWithCateModel:cateModel Success:^(id responseObject) {
                [self.tableView.mj_header beginRefreshing];
            } Failed:^(NSError *error) {
                [AppManager showToastWithMsg:@"添加失败"];
            }];
        } else {
            [[JSRequestManager sharedManager] putCateWithCateModel:cateModel Success:^(id responseObject) {
                [self.tableView.mj_header beginRefreshing];
            } Failed:^(NSError *error) {
                [AppManager showToastWithMsg:@"修改失败"];
            }];
        }
    };
    cell.deleteBlock = ^(JSSHCateModel *cateModel){
        [[JSRequestManager sharedManager] deleteCateWithCateModel:cateModel Success:^(id responseObject) {
            [self.tableView.mj_header beginRefreshing];
        } Failed:^(NSError *error) {
            [AppManager showToastWithMsg:@"修改失败"];
        }];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSSHCateModel *model = self.dataArray[indexPath.row];
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
