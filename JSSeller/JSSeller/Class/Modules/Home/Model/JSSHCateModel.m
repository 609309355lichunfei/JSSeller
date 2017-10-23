//
//  JSSHCateModel.m
//  JSSeller
//
//  Created by 吴頔 on 17/9/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHCateModel.h"

@implementation JSSHCateModel
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.cateid = value;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
