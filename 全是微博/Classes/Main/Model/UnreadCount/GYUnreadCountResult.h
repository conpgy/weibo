//
//  GYUnreadCountResult.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYUnreadCountResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  新提级我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  群消息未读数
 */
@property (nonatomic, assign) int group;

/**
 *  私有群消息未读数
 */
@property (nonatomic, assign) int private_group;

/**
 *  新通知未读数
 */
@property (nonatomic, assign) int notice;

/**
 *  新邀请未读数
 */
@property (nonatomic, assign) int invite;

/**
 *  新勋章数
 */
@property (nonatomic, assign) int badge;

/**
 *  新相册消息未读数
 */
@property (nonatomic, assign) int photo;

/**
 *  消息未读数
 */
- (int)messageCount;

/**
 *  所有未读数
 */
- (int)totalCount;

@end
