//
//  JSSHUserModel.m
//  JSSeller
//
//  Created by 吴頔 on 2017/9/30.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHUserModel.h"

static JSSHUserModel *model;
@implementation JSSHUserModel
+ (JSSHUserModel *)defaultModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[JSSHUserModel alloc] init];
    });
    return model;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"today_income"]) {
        NSNumber *priceNumber = value;
        float price = priceNumber.integerValue / 100.0;
        self.today_income = [NSNumber numberWithFloat:price];
    } else if([key isEqualToString:@"month_income"]) {
        NSNumber *priceNumber = value;
        float price = priceNumber.integerValue / 100.0;
        self.month_income = [NSNumber numberWithFloat:price];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
