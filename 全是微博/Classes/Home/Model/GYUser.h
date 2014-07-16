//
//  GYUser.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYUser : NSObject

/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址(中图), 50*50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;

/**
 *  是否会员
 */
@property (nonatomic, assign, readonly, getter = isVip) BOOL vip;



@end
