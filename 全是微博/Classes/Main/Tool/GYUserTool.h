//
//  GYUserTool.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYUnreadCountParam.h"
#import "GYUnreadCountResult.h"
#import "GYUserInfoParam.h"
#import "GYUserInfoResult.h"

@interface GYUserTool : NSObject

/**
 *  获得未读数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+(void)unreadCountWithParam:(GYUnreadCountParam *)param success:(void (^)(GYUnreadCountResult *))success failure:(void (^)(NSError *))failure;

+(void)userInfoWithParam:(GYUserInfoParam *)param success:(void (^)(GYUserInfoResult *))success failure:(void (^)(NSError *))failure;

@end
