//
//  GYHttpTool.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYHttpTool.h"

@implementation GYHttpTool

+(void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url parameters:(NSDictionary *)params formData:(NSData *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"pic" fileName:@"haha.jpg" mimeType:@"images/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
