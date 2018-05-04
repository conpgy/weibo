//
//  GYStatusTool.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusTool.h"
#import "GYHttpTool.h"
#import "MJExtension.h"
#import "GYHomeStatusesParam.h"
#import "GYHomeStatusesResult.h"
#import "GYSendStatusParam.h"
#import "GYSendStatusResult.h"
#import "MJExtension.h"

@implementation GYStatusTool

+(void)homeStatusesWithParam:(GYHomeStatusesParam *)param success:(void (^)(GYHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    // 发送请求加载首页微博数据
    [GYHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(id responseObj) {
        if (success) {
            GYHomeStatusesResult *result = [GYHomeStatusesResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)sendStatusesWithParam:(GYSendStatusParam *)param success:(void (^)(GYSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    [GYHttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(id responseObj) {
        GYSendStatusResult *result = [GYSendStatusResult objectWithKeyValues:responseObj];
        success(result);
    } failure:^(NSError *error){
        failure(error);
    }];
}

+(void)sendStatusesWithParam:(GYSendStatusParam *)param imageData:(NSData *)imageData success:(void (^)(GYSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    [GYHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params formData:imageData success:^(id responseObj) {
        success(responseObj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
