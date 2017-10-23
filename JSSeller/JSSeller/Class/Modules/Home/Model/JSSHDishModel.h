//
//  JSSHDishModel.h
//  JSSeller
//
//  Created by 吴頔 on 17/9/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSHDishModel : NSObject
@property (strong, nonatomic) NSNumber *dishid;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger finishtime;
@property (assign, nonatomic) NSInteger is_sale;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSNumber *cateid;
@property (strong, nonatomic) NSNumber *price;
@property (assign, nonatomic) NSInteger count;
#pragma mark - 自加属性
@property (assign, nonatomic) BOOL option;
@property (strong, nonatomic) NSString *finishtimeStr;

@end
