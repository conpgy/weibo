//
//  GYLoadMoreFooter.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-10.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYLoadMoreFooter : UIView

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

- (void)beginRefreshing;
- (void)endRefreshing;

+ (instancetype)footer;

@end
