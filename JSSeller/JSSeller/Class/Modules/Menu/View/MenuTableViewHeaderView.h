//
//  MenuTableViewHeaderView.h
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addBT;

@property (copy, nonatomic) void(^addBlock)();
@end
