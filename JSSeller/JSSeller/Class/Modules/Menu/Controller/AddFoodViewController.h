//
//  AddFoodViewController.h
//  JSSeller
//
//  Created by 吴頔 on 17/6/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSSHDishModel;
@interface AddFoodViewController : UIViewController
@property (strong, nonatomic) NSNumber *cateid;
@property (strong, nonatomic) JSSHDishModel *dishModel;
@end
