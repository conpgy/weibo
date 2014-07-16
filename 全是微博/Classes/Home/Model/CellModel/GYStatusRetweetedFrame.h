//
//  GYStatusRetweetedFrame.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYStatus;

@interface GYStatusRetweetedFrame : NSObject

/**
 *  转发微博
 */
@property (nonatomic, strong) GYStatus *retweetedStatus;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;

/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect nameFrame;

/**
 *  文本内容的frame
 */
@property (nonatomic, assign) CGRect textFrame;

/**
 *  配图相册的frame
 */
@property (nonatomic, assign) CGRect photosFrame;

@end
