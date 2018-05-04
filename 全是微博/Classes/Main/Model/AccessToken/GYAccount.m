//
//  GYAccount.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYAccount.h"

@implementation GYAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    GYAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}
/**
 *  当从文件中解析出一个对象的时候调用
 *  这个方法表示怎样读取文件中的数据
 */

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

/**
 *  将对象写入文件时调用
 *  在这个方法中, 写明要存储哪些对象的属性，怎样存储这些属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
