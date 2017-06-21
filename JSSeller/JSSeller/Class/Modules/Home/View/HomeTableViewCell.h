//
//  HomeTableViewCell.h
//  JSSeller
//
//  Created by 吴頔 on 17/6/20.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeTableViewCellType) {
    HomeTableViewCellTypeAwait,
    HomeTableViewCellTypeAccept,
    HomeTableViewCellTypeComplete,
    HomeTableViewCellTypeException
};

@interface HomeTableViewCell : UITableViewCell
@property (assign, nonatomic) HomeTableViewCellType type;
@end
