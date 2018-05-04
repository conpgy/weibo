//
//  GYStatusTool.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYHomeStatusesParam;
@class GYHomeStatusesResult;
@class GYSendStatusParam;
@class GYSendStatusResult;

@interface GYStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+ (void)homeStatusesWithParam:(GYHomeStatusesParam *)param success:(void (^)(GYHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送不带图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+(void)sendStatusesWithParam:(GYSendStatusParam *)param success:(void (^)(GYSendStatusResult *))success failure:(void (^)(NSError *))failure;

/**
 *  发送带图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+(void)sendStatusesWithParam:(GYSendStatusParam *)param imageData:(NSData *)imageData success:(void (^)(GYSendStatusResult *))success failure:(void (^)(NSError *))failure;

@end
