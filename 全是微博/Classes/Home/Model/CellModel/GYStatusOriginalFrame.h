//
//  GYStatusOriginalFrame.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYStatus;

@interface GYStatusOriginalFrame : NSObject

/**
 *  原创微博数据
 */
@property (nonatomic, strong) GYStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;

/**
 *  头像的frame
 */
@property (nonatomic, assign) CGRect iconFrame;

/**
 *  文本内容的frame
 */
@property (nonatomic, assign) CGRect textFrame;

/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect nameFrame;

/**
 *  vip图标的frame
 */
@property (nonatomic, assign) CGRect vipFrame;

/**
 *  图片的frame
 */
@property (nonatomic, assign) CGRect pictureFrame;

/**
 *  配图相册的frame
 */
@property (nonatomic, assign) CGRect photosFrame;


@end
