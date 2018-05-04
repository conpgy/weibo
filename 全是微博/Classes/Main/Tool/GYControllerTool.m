//
//  GYControllerTool.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYControllerTool.h"
#import "GYTabBarController.h"
#import "GYNewFeatureViewController.h"

@implementation GYControllerTool

+ (void)chooseRootViewController
{
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 取出沙盒中存储的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults valueForKey:versionKey];
    
    // 取出当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 进行版本号比较
    if ([currentVersion isEqualToString:lastVersion]) { // 如果两个版本号一致，则跳转到GYTabBarController
        window.rootViewController = [[GYTabBarController alloc] init];
    } else {    // 两个版本号不一致，则跳转到GYNewFeatureViewController
        window.rootViewController = [[GYNewFeatureViewController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}
@end
