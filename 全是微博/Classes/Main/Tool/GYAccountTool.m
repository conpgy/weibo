//
//  GYAccountTool.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYAccountTool.h"
#import "GYAccount.h"
#import "MJExtension.h"
#import "GYHttpTool.h"

#define GYAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation GYAccountTool

/**
 *  存储帐号
 */

+(void)save:(GYAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile: GYAccountFilePath];
}

+(GYAccount *)account
{
    GYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:GYAccountFilePath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_time] != NSOrderedAscending) {
        account = nil;
        GYLog(@"不会把");
    }
    
    return account;
}

+(void)accessTokenWithParam:(GYAccessTokenParam *)param success:(void (^)(GYAccount *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    [GYHttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id responseObj) {
        if (success) {
            GYAccount *result = [GYAccount accountWithDict:responseObj];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

@end
