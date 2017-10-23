//
//  MenuTableViewCell.h
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSHDishModel;
@interface MenuTableViewCell : UITableViewCell
@property (strong, nonatomic) JSSHDishModel *dishModel;

@property (copy, nonatomic) void(^deleteBlock)(JSSHDishModel *dishModel);

@end
