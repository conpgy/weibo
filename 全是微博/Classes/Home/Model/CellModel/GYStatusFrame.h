//
//  GYWeibo.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYStatus, GYStatusDetailFrame;

@interface GYStatusFrame : NSObject

/**
 *  每条微博的元数据
 */
@property (nonatomic, strong) GYStatus *status;

/**
 *  设置微博详情的frame
 */
@property (nonatomic, strong) GYStatusDetailFrame *detailFrame;

/**
 *  设置工具条的frame
 */
@property (nonatomic, assign) CGRect toolbarFrame;

/**
 *  每条微博的高度
 */
@property (nonatomic, assign) CGFloat cellHight;


@end
