//
//  HomeViewController.m
//  YYSeller
//
//  Created by 李春菲 on 17/6/16.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "JSSHOrderModel.h"
#import "JSSHUserModel.h"
#import <JPUSHService.h>

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger _pageIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *xinBT;
@property (weak, nonatomic) IBOutlet UIButton *acceptedBT;
@property (weak, nonatomic) IBOutlet UIButton *completedBT;
@property (weak, nonatomic) IBOutlet UIButton *exceptionBT;
@property (weak, nonatomic) IBOutlet UINavigationItem *myTitleItem;


@property (strong, nonatomic) UIView *signView;

@property (assign, nonatomic) HomeTableViewCellType type;

@property (strong, nonatomic) UIButton *currentBT;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *awaitArray;
@property (strong, nonatomic) NSMutableArray *acceptArray;
@property (strong, nonatomic) NSMutableArray *completedArray;
@property (strong, nonatomic) NSMutableArray *exceptionArray;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[JSRequestManager sharedManager] getInfoWithSuccess:^(id responseObject) {
        [[JSSHUserModel defaultModel] setValuesForKeysWithDictionary:responseObject[@"data"]];
        self.myTitleItem.title = [JSSHUserModel defaultModel].shopname;
    } Failed:^(NSError *error) {
        
    }];
    
}

- (void)registUI {
    _type = HomeTableViewCellTypeAwait;
    self.signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 2)];
    self.signView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    _currentBT = _xinBT;
    _type = HomeTableViewCellTypeAwait;
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getConnectWithDataLoadType:DataLoadTypeNone];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getConnectWithDataLoadType:DataLoadTypeMore];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)getConnectWithDataLoadType:(DataLoadType)dataLoadType {
    NSString *typeStr = nil;
    switch (_type) {
        case HomeTableViewCellTypeAwait:
            typeStr = @"1";
            break;
        case HomeTableViewCellTypeAccept:
            typeStr = @"2";
            break;
        case HomeTableViewCellTypeComplete:
            typeStr = @"3";
            break;
        case HomeTableViewCellTypeException:
            typeStr = @"4";
            break;
            
        default:
            break;
    }
    _pageIndex = dataLoadType == DataLoadTypeNone ? 0 : _pageIndex + 1;
    [[JSRequestManager sharedManager] getOrdersWithPage:[NSString stringWithFormat:@"%ld",_pageIndex] status:typeStr Success:^(id responseObject) {
        if (dataLoadType == DataLoadTypeNone) {
            switch (_type) {
            case HomeTableViewCellTypeAwait:
                [self.awaitArray removeAllObjects];
                break;
            case HomeTableViewCellTypeAccept:
                [self.acceptArray removeAllObjects];
                break;
            case HomeTableViewCellTypeComplete:
                [self.completedArray removeAllObjects];
                break;
            case HomeTableViewCellTypeException:
                [self.exceptionArray removeAllObjects];
                break;
                
            default:
                break;
            }
            
        }
        NSArray *orderDicArray = responseObject[@"data"][@"orders"];
        for (NSDictionary *orderDic in orderDicArray) {
            JSSHOrderModel *model = [[JSSHOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:orderDic];
            [UserManager sharedManager].timerinterval = model.nowtime - [AppManager getNowTimestamp];
            [model autoGetHeight];
            switch (_type) {
                case HomeTableViewCellTypeAwait:
                    [self.awaitArray addObject:model];
                    break;
                case HomeTableViewCellTypeAccept:
                    [self.acceptArray addObject:model];
                    break;
                case HomeTableViewCellTypeComplete:
                    [self.completedArray addObject:model];
                    break;
                case HomeTableViewCellTypeException:
                    [self.exceptionArray addObject:model];
                    break;
                    
                default:
                    break;
            }
        }
        switch (_type) {
            case HomeTableViewCellTypeAwait:
                self.dataArray = self.awaitArray;
                break;
            case HomeTableViewCellTypeAccept:
               self.dataArray = self.acceptArray;
                break;
            case HomeTableViewCellTypeComplete:
                self.dataArray = self.completedArray;
                break;
            case HomeTableViewCellTypeException:
                self.dataArray = self.exceptionArray;
                break;
                
            default:
                break;
        }
        
        if (dataLoadType == DataLoadTypeNone) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];
        
    } Failed:^(NSError *error) {
        if (dataLoadType == DataLoadTypeNone) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}



- (IBAction)newIndentAction:(id)sender {
    if (_currentBT == _xinBT) {
        return;
    }
    _type = HomeTableViewCellTypeAwait;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _xinBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.dataArray = self.awaitArray;
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
    self.dataArray = self.acceptArray;
    [self.tableView reloadData];
    if (self.dataArray.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }

}

- (IBAction)completeIndentAction:(id)sender {
    if (_currentBT == _completedBT) {
        return;
    }
    _type = HomeTableViewCellTypeComplete;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _completedBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.dataArray = self.completedArray;
    [self.tableView reloadData];
    if (self.dataArray.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (IBAction)exceptionIndentAction:(id)sender {
    if (_currentBT == _exceptionBT) {
        return;
    }
    _type = HomeTableViewCellTypeException;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _currentBT = _exceptionBT;
    _currentBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.dataArray = self.exceptionArray;
    [self.tableView reloadData];
    if (self.dataArray.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSSHOrderModel *model = self.dataArray[indexPath.row];
    return model.height;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    cell.type = _type;
    JSSHOrderModel *model = self.dataArray[indexPath.row];
    cell.orderModel = model;
    cell.btactionBlock = ^{
        [tableView.mj_header beginRefreshing];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 懒加载
- (NSMutableArray *)awaitArray {
    if (_awaitArray == nil) {
        _awaitArray = [NSMutableArray array];
    }
    return _awaitArray;
}

- (NSMutableArray *)acceptArray {
    if (_acceptArray == nil) {
        _acceptArray = [NSMutableArray array];
    }
    return _acceptArray;
}

- (NSMutableArray *)completedArray {
    if (_completedArray == nil) {
        _completedArray = [NSMutableArray array];
    }
    return _completedArray;
}

- (NSMutableArray *)exceptionArray {
    if (_exceptionArray == nil) {
        _exceptionArray = [NSMutableArray array];
    }
    return _exceptionArray;
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
