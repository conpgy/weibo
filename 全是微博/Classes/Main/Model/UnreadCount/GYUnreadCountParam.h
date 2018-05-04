//
//  GYUnreadCountParam.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYBaseParam.h"

@interface GYUnreadCountParam : GYBaseParam

/**
 *  int64	需要获取消息未读数的用户UID，必须是当前登录用户。
 */

@property (nonatomic, copy) NSString *uid;


@end
