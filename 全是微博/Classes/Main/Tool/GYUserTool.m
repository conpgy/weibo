//
//  GYUserTool.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYUserTool.h"
#import "MJExtension.h"
#import "GYHttpTool.h"

@implementation GYUserTool

+(void)unreadCountWithParam:(GYUnreadCountParam *)param success:(void (^)(GYUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    // 发送请求加载首页微博数据
    [GYHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(id responseObj) {
        if (success) {
            GYUnreadCountResult *result = [GYUnreadCountResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)userInfoWithParam:(GYUserInfoParam *)param success:(void (^)(GYUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    // 发送请求加载首页微博数据
    [GYHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(id responseObj) {
        if (success) {
            GYUserInfoResult *result = [GYUserInfoResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
