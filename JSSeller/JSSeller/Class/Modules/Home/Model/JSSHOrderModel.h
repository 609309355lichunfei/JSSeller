//
//  JSSHOrderModel.h
//  JSSeller
//
//  Created by 吴頔 on 2017/9/29.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSHOrderModel : NSObject
@property (assign, nonatomic) NSInteger cancel;
@property (strong, nonatomic) NSString *addressdet;
@property (assign, nonatomic) NSInteger riderid;
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) NSString *ridername;
@property (strong, nonatomic) NSMutableArray *dishs;
@property (strong, nonatomic) NSNumber *lastprice;
@property (assign, nonatomic) NSInteger cookfinishstatus;
@property (assign, nonatomic) NSInteger paystatus;
@property (assign, nonatomic) NSInteger memberid;
@property (assign, nonatomic) NSInteger nowtime;
@property (strong, nonatomic) NSString *riderphone;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *order_no;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger child_no;
@property (assign, nonatomic) NSInteger paytime;
@property (strong, nonatomic) NSNumber *orderid;
@property (assign, nonatomic) NSInteger shopaccept;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *phone;

#pragma mark - 自加属性

@property (assign, nonatomic) CGFloat height;

- (void)autoGetHeight;

@end
