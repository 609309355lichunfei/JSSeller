//
//  JSRequestManager.h
//  JSSeller
//
//  Created by 吴頔 on 17/9/19.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNetworkHelper.h"


@class JSSHDishModel,JSSHCateModel,JSSHUserModel;
@interface JSRequestManager : NSObject

@property (assign, nonatomic) BOOL jpushLogin;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *token;

+ (JSRequestManager *)sharedManager;

- (void)loginWithUserName:(NSString *)userName
                  Passord:(NSString *)password
                  Success:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed;


/**
 退出登录
 
 */
- (void)logoutWithSuccess:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed;


/**
 获取验证码

 @param phoneNumber 电话号码
 */
- (void)postSmsPhoneNumber:(NSString *)phoneNumber
                   Success:(PPHttpRequestSuccess)success
                    Failed:(PPHttpRequestFailed)failed;


/**
 获取商家信息

 */
- (void)getInfoWithSuccess:(PPHttpRequestSuccess)success
                    Failed:(PPHttpRequestFailed)failed;


/**
 修改信息

 @param userModel 用户
 */
- (void)putInfoWithUserModel:(JSSHUserModel *)userModel
                        data:(NSData *)data
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed;


/**
 获取菜品分类

 */
- (void)getCatesWithSuccess:(PPHttpRequestSuccess)success
                     Failed:(PPHttpRequestFailed)failed;


/**
 修改菜品分类

 @param cateModel 菜品分类
 */
- (void)putCateWithCateModel:(JSSHCateModel *)cateModel
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed;


/**
 新增菜品分类

 @param cateModel 菜品分类
 */
- (void)postCateWithCateModel:(JSSHCateModel *)cateModel
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed;


/**
 删除菜品分类

 @param cateModel 菜品分类
 */
- (void)deleteCateWithCateModel:(JSSHCateModel *)cateModel
                        Success:(PPHttpRequestSuccess)success
                         Failed:(PPHttpRequestFailed)failed;



/**
 获取菜品

 */
- (void)getDishsWithCateid:(NSString *)cateid
                   Success:(PPHttpRequestSuccess)success
                     Failed:(PPHttpRequestFailed)failed;


/**
 修改菜品

 @param dishModel 菜品
 */
- (void)putDishWithDishModel:(JSSHDishModel *)dishModel
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed;

- (void)putDishWithDishModel:(JSSHDishModel *)dishModel
                       data:(NSData *)data
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed;


/**
 新增菜品

 @param dishModel 菜品
 */
- (void)postDishWithDishModel:(JSSHDishModel *)dishModel
                        image:(UIImage *)image
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed ;


/**
 删除菜品

 @param dishModel 菜品
 */
- (void)deleteDishWithDishModel:(JSSHDishModel *)dishModel
                        Success:(PPHttpRequestSuccess)success
                         Failed:(PPHttpRequestFailed)failed;


/**
 查看订单

 @param page 页数
 */
- (void)getOrdersWithPage:(NSString *)page
                   status:(NSString *)status
                  Success:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed;


/**
 接单

 @param orderno 订单号
 */
- (void)acceptOrderWithOderno:(NSString *)orderno
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed;


/**
 做完菜

 @param orderno 订单号
 */
- (void)cookfinishWithOrderno:(NSString *)orderno
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed;


/**
 获取订单数和收入

 */
- (void)getSalesSuccess:(PPHttpRequestSuccess)success
                 Failed:(PPHttpRequestFailed)failed;


@end
