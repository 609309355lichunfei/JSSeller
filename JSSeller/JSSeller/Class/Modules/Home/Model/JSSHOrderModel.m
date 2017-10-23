//
//  JSSHOrderModel.m
//  JSSeller
//
//  Created by 吴頔 on 2017/9/29.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHOrderModel.h"
#import "JSSHDishModel.h"

@implementation JSSHOrderModel
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"price"]) {
        NSNumber *priceNumber = value;
        CGFloat price = priceNumber.integerValue / 100.0;
        self.price = [NSNumber numberWithFloat:price];
    } else if ([key isEqualToString:@"lastprice"]) {
        NSNumber *priceNumber = value;
        CGFloat price = priceNumber.integerValue / 100.0;
        self.lastprice = [NSNumber numberWithFloat:price];
    } else if ([key isEqualToString:@"dishs"]) {
        NSArray *dishDicArray = value;
        NSMutableArray *dishArray = [NSMutableArray array];
        for (NSDictionary *dishDic in dishDicArray) {
            JSSHDishModel *model = [[JSSHDishModel alloc] init];
            [model setValuesForKeysWithDictionary:dishDic];
            [dishArray addObject:model];
        }
        self.dishs = dishArray;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.orderid = value;
    }
}

- (void)autoGetHeight {
    CGFloat remarkHeight = [self.remark heightForFont:[UIFont fontWithName:App_FamilyFontName size:12] width:(KScreenWidth - 94)];
    if (remarkHeight == 0) {
        remarkHeight = 17;
    }
    
    CGFloat btHeight = 0;
    
    if (self.status == 1 || self.status == 2) {
        btHeight = 66;
    }
    
    self.height = 280 + 30 * self.dishs.count + remarkHeight + btHeight;
}

@end
