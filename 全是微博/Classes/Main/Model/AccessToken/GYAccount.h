//
//  GYAccount.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYAccount : NSObject <NSCoding>

/**
 *  用于调用access_token, 获取授权后的access token
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  access_token的生命周期, 单位是秒数
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  过期时间
 */
@property (nonatomic, copy) NSDate *expires_time;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
