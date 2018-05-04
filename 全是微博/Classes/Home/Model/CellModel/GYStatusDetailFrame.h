//
//  GYStatusDetailFrame.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GYStatus, GYStatusOriginalFrame, GYStatusRetweetedFrame;

@interface GYStatusDetailFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) GYStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;

/**
 *  原创微博的frame
 */
@property (nonatomic, strong) GYStatusOriginalFrame *originalFrame;

/**
 *  转发微博的frame
 */
@property (nonatomic, strong) GYStatusRetweetedFrame *retweetedFrame;


@end
