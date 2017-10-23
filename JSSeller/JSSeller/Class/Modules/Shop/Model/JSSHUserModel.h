//
//  JSSHUserModel.h
//  JSSeller
//
//  Created by 吴頔 on 2017/9/30.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSHUserModel : NSObject
@property (strong, nonatomic) NSNumber *lng;
@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSString *contents;
@property (strong, nonatomic) NSNumber *today_income;
@property (strong, nonatomic) NSNumber *month_income;
@property (assign, nonatomic) NSInteger is_open;
@property (assign, nonatomic) NSInteger memberid;
@property (strong, nonatomic) NSString *notice_info;
@property (strong, nonatomic) NSString *addressdet;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *intr_info;
@property (strong, nonatomic) NSString *shopname;


+ (JSSHUserModel *)defaultModel;
@end
