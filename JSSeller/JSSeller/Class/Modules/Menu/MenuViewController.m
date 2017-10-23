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
#import "ClassifyControlViewController.h"
#import "AddFoodViewController.h"
#import "JSSHCateModel.h"
#import "JSSHDishModel.h"


@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *cateNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL isDish;
@property (strong, nonatomic) JSSHCateModel *cateModel;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *cateArray;
@property (strong, nonatomic) NSMutableArray *dishArray;



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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuCateTableViewCell"];
    _isHidden = YES;
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_isDish) {
            [weakSelf getConnectDish];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.cateModel = nil;
    _isDish = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)getConnectCates{
    [[JSRequestManager sharedManager] getCatesWithSuccess:^(id responseObject) {
        [self.cateArray removeAllObjects];
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *cateDicArray = dataDic[@"cates"];
        for (NSDictionary *cateDic in cateDicArray) {
            JSSHCateModel *model = [[JSSHCateModel alloc] init];
            [model setValuesForKeysWithDictionary:cateDic];
            [self.cateArray addObject:model];
        }
        if (self.cateArray.count > 0) {
            self.cateModel = [self.cateArray firstObject];
            self.cateNameLabel.text = self.cateModel.cate;
            [self getConnectDish];
        } else {
           [self.tableView.mj_header endRefreshing];
        }
        if (!_isDish) {
            self.dataArray = self.cateArray;
            [self.tableView reloadData];
        }
    } Failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)getConnectDish {
    if (_cateModel == nil) {
        [self getConnectCates];
        return;
    }
    [[JSRequestManager sharedManager] getDishsWithCateid:self.cateModel.cateid.stringValue Success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.dishArray removeAllObjects];
        NSDictionary *dishDicArray = responseObject[@"data"][@"dishs"];
        for (NSDictionary *dishDic in dishDicArray) {
            JSSHDishModel *dishModel = [[JSSHDishModel alloc] init];
            [dishModel setValuesForKeysWithDictionary:dishDic];
            [self.dishArray addObject:dishModel];
        }
        if (_isDish) {
            self.dataArray = self.dishArray;
            [self.tableView reloadData];
        }
        
    } Failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (IBAction)classifyControllAction:(id)sender {
    ClassifyControlViewController *classifyControlVC = [[ClassifyControlViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:classifyControlVC animated:YES];
}

- (IBAction)chooseCateAction:(id)sender {
    if (_isDish == YES) {
        _isDish = NO;
        [self getConnectCates];
    } else {
        _isDish = YES;
        self.dataArray = self.dishArray;
        [self.tableView reloadData];
    }
    
    
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDish) {
        JSSHDishModel *model = self.dataArray[indexPath.row];
        if (model.option) {
            return 90;
        } else {
            return 50;
        }
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
    if (_isDish) {
        MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JSSHDishModel *model = self.dataArray[indexPath.row];
        cell.dishModel = model;
        cell.deleteBlock = ^(JSSHDishModel *dishModel) {
            [[JSRequestManager sharedManager] deleteDishWithDishModel:dishModel Success:^(id responseObject) {
                [self.tableView.mj_header beginRefreshing];
            } Failed:^(NSError *error) {
                [AppManager showToastWithMsg:@"删除失败"];
            }];
        };
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCateTableViewCell" forIndexPath:indexPath];
        JSSHCateModel *cateModel = self.dataArray[indexPath.row];
        cell.textLabel.text = cateModel.cate;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_isDish) {
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MenuTableViewHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"MenuTableViewHeaderView" owner:self options:nil]lastObject];
    [view.addBT setTitle:@"+ 添加菜品" forState:UIControlStateNormal];
    MJWeakSelf;
    view.addBlock = ^(){
        AddFoodViewController *addFoodVC = [[AddFoodViewController alloc]init];
        addFoodVC.cateid = _cateModel.cateid;
        [weakSelf.parentViewController.navigationController pushViewController:addFoodVC animated:YES];
    };
    return view;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDish) {
        JSSHDishModel *model = self.dataArray[indexPath.row];
        model.option = !model.option;
        [tableView reloadRowAtIndexPath:indexPath withRowAnimation:(UITableViewRowAnimationFade)];
    } else {
        JSSHCateModel *model = self.dataArray[indexPath.row];
        self.cateModel = model;
        self.cateNameLabel.text = _cateModel.cate;
        _isDish = YES;
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)cateArray {
    if (_cateArray == nil) {
        _cateArray = [NSMutableArray array];
    }
    return _cateArray;
}

- (NSMutableArray *)dishArray {
    if (_dishArray == nil) {
        _dishArray = [NSMutableArray array];
    }
    return _dishArray;
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
