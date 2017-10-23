//
//  JSSHCateModel.h
//  JSSeller
//
//  Created by 吴頔 on 17/9/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSHCateModel : NSObject
@property (strong, nonatomic) NSNumber *cateid;
@property (strong, nonatomic) NSString *cate;

#pragma mark - 自加属性
@property (assign, nonatomic) BOOL option;
@property (assign, nonatomic) BOOL isEdit;
@property (assign, nonatomic) BOOL isAdd;
@end

