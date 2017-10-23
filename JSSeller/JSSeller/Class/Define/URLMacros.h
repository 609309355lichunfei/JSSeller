//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"https://api.calleat.cn"
//#define URL_main @"http://192.168.11.122:8090" //展鹏

#elif TestSever

/**测试服务器*/
#define URL_main @"http://192.168.20.31:20000"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://192.168.20.31:20000"
#endif



#pragma mark - 详细接口地址

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"/api/cast/home/start"

//登录接口
#define URL_Login [NSString stringWithFormat:@"%@/v1/login/merchant/", URL_main]
//登出接口
#define URL_Logout [NSString stringWithFormat:@"%@/v1/logout/", URL_main]
//短信验证码
#define URL_Sms [NSString stringWithFormat:@"%@/v1/sms/", URL_main]
//商家信息获取
#define URL_Info [NSString stringWithFormat:@"%@/v1/merchant/info/", URL_main]
//菜品(增删改)
#define URL_dish [NSString stringWithFormat:@"%@/v1/merchant/dish/", URL_main]
//获取菜品(查)
#define URL_GETdishs [NSString stringWithFormat:@"%@/v1/merchant/dishs/", URL_main]
//类别(增删改)
#define URL_cate [NSString stringWithFormat:@"%@/v1/merchant/cate/", URL_main]
//类别(查)
#define URL_cates [NSString stringWithFormat:@"%@/v1/merchant/cates/", URL_main]
//查看订单
#define URL_Orders [NSString stringWithFormat:@"%@/v1/merchant/orders/", URL_main]
//商家接单
#define URL_Acceptorder [NSString stringWithFormat:@"%@/v1/merchant/acceptorder/", URL_main]
//做完菜
#define URL_Cookfinish [NSString stringWithFormat:@"%@/v1/merchant/cookfinish/", URL_main]
//订单数和收入
#define URL_Sales [NSString stringWithFormat:@"%@/v1/merchant/sales/", URL_main]


#endif /* URLMacros_h */
