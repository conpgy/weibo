//
//  GYAccountTool.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYAccount.h"
#import "GYAccessTokenParam.h"

@interface GYAccountTool : NSObject

/**
 *  存储帐号
 *
 *  @param account 帐号模型
 */
+ (void)save:(GYAccount *)account;

/**
 *  读取帐号
 */
+(GYAccount *)account;

/**
 *  获得accessToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+(void)accessTokenWithParam:(GYAccessTokenParam *)param success:(void (^)(GYAccount *account))success failure:(void (^)(NSError *error))failure;

@end
