//
//  JSSHDishModel.m
//  JSSeller
//
//  Created by 吴頔 on 17/9/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHDishModel.h"

@implementation JSSHDishModel
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.dishid = value;
    } else if ([key isEqualToString:@"price"]) {
        NSNumber *priceNumber = value;
        float price = priceNumber.integerValue / 100.0;
        self.price = [NSNumber numberWithFloat:price];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
