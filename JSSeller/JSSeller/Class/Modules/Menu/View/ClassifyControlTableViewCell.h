//
//  ClassifyControlTableViewCell.h
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSHCateModel;
@interface ClassifyControlTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *doneBT;
@property (strong, nonatomic) JSSHCateModel *model;
@property (copy, nonatomic) void(^doneBlock)(JSSHCateModel *model);
@property (copy, nonatomic) void (^deleteBlock)(JSSHCateModel *model);
@end
