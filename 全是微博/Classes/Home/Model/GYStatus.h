//
//  GYStatus.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYUser;

@interface GYStatus : NSObject

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博富文本信息内容
 */
@property (nonatomic, copy) NSAttributedString *attributeText;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  微博作者信息
 */
@property (nonatomic, strong) GYUser *user;

/**
 *  被转发的原微博，当该微博为转发微博时返回
 */
@property (nonatomic, strong) GYStatus *retweeted_status;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博配图地址，多图时返回多图链接,无图返回“[]”, 数组里面都是GYPhoto原型
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
