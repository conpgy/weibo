//
//  GYPhoto.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYPhoto : NSObject

/**
 *  缩略图
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 *  大图
 */
@property (nonatomic, copy) NSString *bmiddle_pic;


+ (instancetype)photoWithDict:(NSDictionary *)dict;

@end
