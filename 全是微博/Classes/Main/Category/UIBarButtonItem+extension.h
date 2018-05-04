//
//  UIBarButtonItem+extension.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (extension)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
