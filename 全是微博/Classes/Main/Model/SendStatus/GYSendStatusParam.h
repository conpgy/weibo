//
//  GYComposeStatusParam.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYBaseParam.h"

@interface GYSendStatusParam : GYBaseParam

/**
 *  string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;

/**
 *  图片二进制数据
 */
@property (nonatomic, strong) NSData *imageData;

@end
