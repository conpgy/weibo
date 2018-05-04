//
//  GYHomeStatusesResult.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYHomeStatusesResult : NSObject

/**
 *  微博数组
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  近期的微博总数
 */
@property (nonatomic, assign) int total_number;


@end
