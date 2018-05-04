//
//  GYBaseParam.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYBaseParam : NSObject

/** string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
