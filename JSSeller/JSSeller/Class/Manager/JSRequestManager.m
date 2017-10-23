//
//  JSRequestManager.m
//  JSSeller
//
//  Created by 吴頔 on 17/9/19.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSRequestManager.h"
#import <JPUSHService.h>
#import "JSSHCateModel.h"
#import "JSSHDishModel.h"
#import "JSSHUserModel.h"
#import "JSLoginViewController.h"
#import "LCPanNavigationController.h"
#define JSRequest_Token [NSString stringWithFormat:@"bearer %@",_token]

@implementation JSRequestManager
+ (JSRequestManager *)sharedManager {
    static JSRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JSRequestManager alloc] init];
        manager.token = [[NSUserDefaults standardUserDefaults] valueForKey:@"JSSHToken"];
        manager.userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"JSSHUserName"];
        
    });
    return manager;
}

- (void)setHeaderToken {
    [PPNetworkHelper closeAES];
    if (_token != nil && _token.length > 0 ) {
        [PPNetworkHelper setValue:JSRequest_Token forHTTPHeaderField:@"Authorization"];
    } else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"JSYHToken"];
        _token = token;
        [PPNetworkHelper setValue:JSRequest_Token forHTTPHeaderField:@"Authorization"];
    }
}

- (void)judgeErrorReasonWithError:(NSError *)error {
    if ([error.userInfo[NSLocalizedDescriptionKey] isEqualToString:@"Request failed: unauthorized (401)"]) {
        JSLoginViewController *loginVC = [[JSLoginViewController alloc] init];
        [[AppDelegate shareAppDelegate].mainNavi presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)loginWithUserName:(NSString *)userName
                  Passord:(NSString *)password
                  Success:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed {
    NSDictionary *dic = @{@"phone" : userName, @"pin" : password};
    [PPNetworkHelper POST:URL_Login parameters:dic success:^(id responseObject) {
        
        [MBProgressHUD hideHUD];
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            self.userName = userName;
            NSString *token = responseObject[@"data"][@"token"];
            self.token = token;
            [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"JSSHToken"];
            [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"JSSHUserName"];
            [PPNetworkHelper setValue:[NSString stringWithFormat:@"bearer %@",token]forHTTPHeaderField:@"Authorization"];
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
//        [[JSRequestManager sharedManager] getMemberInfoSuccess:^(id responseObject) {
//            NSDictionary *dataDic = responseObject[@"data"];
//            [[JSYHUserModel defaultModel] setValuesForKeysWithDictionary:dataDic];
//        } Failed:^(NSError *error) {
//            
//        }];
    } failure:^(NSError *error) {
        failed(error);
    }];
}

- (void)logoutWithSuccess:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    [PPNetworkHelper POST:URL_Logout parameters:nil success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
            _token = nil;
            _userName = nil;
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"JSSHToken"];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"JSSHUserName"];
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

- (void)postSmsPhoneNumber:(NSString *)phoneNumber
                   Success:(PPHttpRequestSuccess)success
                    Failed:(PPHttpRequestFailed)failed {
    [PPNetworkHelper POST:URL_Sms parameters:@{@"phone":phoneNumber} success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

- (void)getInfoWithSuccess:(PPHttpRequestSuccess)success
                    Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    [PPNetworkHelper GET:URL_Info parameters:nil success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)putInfoWithUserModel:(JSSHUserModel *)userModel
                        data:(NSData *)data
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = nil;
    if (userModel == nil) {
        
    } else {
        dic = @{@"lng":userModel.lng.stringValue,@"lat":userModel.lat.stringValue,@"phone":userModel.phone,@"is_open":[NSString stringWithFormat:@"%ld",userModel.is_open],@"notice_info":userModel.notice_info,@"address":userModel.address,@"addressdet":userModel.addressdet,@"shopname":userModel.shopname,@"contents":userModel.contents,@"intr_info":userModel.intr_info,@"today_income":userModel.today_income,@"month_income":userModel.month_income,@"memberid":[NSString stringWithFormat:@"%ld",userModel.memberid]};
    }
    
    [PPNetworkHelper PUT:URL_Info parameters:dic data:data responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}

- (void)getCatesWithSuccess:(PPHttpRequestSuccess)success
                     Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    [PPNetworkHelper GET:URL_cates parameters:nil success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}


- (void)putCateWithCateModel:(JSSHCateModel *)cateModel
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"cateid":cateModel.cateid.stringValue, @"cate":cateModel.cate};
    [PPNetworkHelper PUT:URL_cate parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)postCateWithCateModel:(JSSHCateModel *)cateModel
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"cateid":@"0", @"cate":cateModel.cate};
    [PPNetworkHelper POST:URL_cate parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)deleteCateWithCateModel:(JSSHCateModel *)cateModel
                        Success:(PPHttpRequestSuccess)success
                         Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"cateid":cateModel.cateid.stringValue, @"cate":cateModel.cate};    [PPNetworkHelper DELETE:URL_cate parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)getDishsWithCateid:(NSString *)cateid
                   Success:(PPHttpRequestSuccess)success
                    Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"cateid":cateid};
    [PPNetworkHelper GET:URL_GETdishs parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)putDishWithDishModel:(JSSHDishModel *)dishModel
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"finishtime":[NSString stringWithFormat:@"%ld",dishModel.finishtime], @"is_sale":[NSString stringWithFormat:@"%ld",dishModel.is_sale],@"price":dishModel.price.stringValue,@"cateid":dishModel.cateid.stringValue,@"info":dishModel.info,@"name":dishModel.name,@"dishid":dishModel.dishid.stringValue,@"is_delete":@"1"};
    [PPNetworkHelper PUT:URL_dish parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)putDishWithDishModel:(JSSHDishModel *)dishModel
                       data:(NSData *)data
                     Success:(PPHttpRequestSuccess)success
                      Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"finishtime":[NSString stringWithFormat:@"%ld",dishModel.finishtime], @"is_sale":[NSString stringWithFormat:@"%ld",dishModel.is_sale],@"price":dishModel.price.stringValue,@"cateid":dishModel.cateid.stringValue,@"info":dishModel.info,@"name":dishModel.name,@"dishid":dishModel.dishid.stringValue,@"is_delete":@"1"};
    [PPNetworkHelper PUT:URL_dish parameters:dic data:data responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)postDishWithDishModel:(JSSHDishModel *)dishModel
                        image:(UIImage *)image
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"finishtime":dishModel.finishtimeStr, @"is_sale":@"1",@"price":dishModel.price.stringValue,@"cateid":dishModel.cateid.stringValue,@"info":dishModel.info,@"name":dishModel.name,@"dishid":@"0",@"is_delete":@"1"};
    [PPNetworkHelper uploadImagesWithURL:URL_dish parameters:dic name:@"data.png" images:@[image] fileNames:@[@"data"] imageScale:0.7 imageType:@"png" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)deleteDishWithDishModel:(JSSHDishModel *)dishModel
                        Success:(PPHttpRequestSuccess)success
                         Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"finishtime":[NSString stringWithFormat:@"%ld",dishModel.finishtime], @"is_sale":[NSString stringWithFormat:@"%ld",dishModel.is_sale],@"price":dishModel.price.stringValue,@"cateid":dishModel.cateid.stringValue,@"info":dishModel.info,@"name":dishModel.name,@"dishid":dishModel.dishid.stringValue,@"is_delete":@"1"};
    [PPNetworkHelper DELETE:URL_dish parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

- (void)getOrdersWithPage:(NSString *)page
                   status:(NSString *)status
                  Success:(PPHttpRequestSuccess)success
                   Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"page":page,@"status":status};
    [PPNetworkHelper GET:URL_Orders parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)acceptOrderWithOderno:(NSString *)orderno
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"order_no":orderno};
    [PPNetworkHelper POST:URL_Acceptorder parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)cookfinishWithOrderno:(NSString *)orderno
                      Success:(PPHttpRequestSuccess)success
                       Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    NSDictionary *dic = @{@"order_no":orderno};
    [PPNetworkHelper POST:URL_Cookfinish parameters:dic success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}

- (void)getSalesSuccess:(PPHttpRequestSuccess)success
                 Failed:(PPHttpRequestFailed)failed {
    [self setHeaderToken];
    [PPNetworkHelper GET:URL_Sales parameters:nil success:^(id responseObject) {
        NSNumber *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToNumber:@0]) {
            success(responseObject);
        } else {
            [AppManager showToastWithMsg:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self judgeErrorReasonWithError:error];
        failed(error);
    }];
}


@end
