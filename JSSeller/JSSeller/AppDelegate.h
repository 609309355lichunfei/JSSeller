//
//  AppDelegate.h
//  JSSeller
//
//  Created by 李春菲 on 17/6/19.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class LCPanNavigationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) LCPanNavigationController *mainNavi;

- (void)saveContext;


@end

