//
//  GYHttpTool.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GYHttpTool : NSObject

+ (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(NSDictionary *)params formData:(NSData *)data success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
@end
