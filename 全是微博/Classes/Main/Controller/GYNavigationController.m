//
//  GYNavigationController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYNavigationController.h"

@interface GYNavigationController ()

@end

@implementation GYNavigationController

+(void)initialize
{
    [self setupBarButtonItemTheme];
    
    [self setupNavigationBarTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置导航栏背景
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 设置字体属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:20];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    // 取消字体阴影
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [navBar setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */

+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    // 设置普通状态的字体属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的字体属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [barButtonItem setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态（disable）下的字体属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [barButtonItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    // 设置按钮的背景
    [barButtonItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
