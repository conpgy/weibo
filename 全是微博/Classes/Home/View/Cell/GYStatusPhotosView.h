//
//  GYPhotosView.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-16.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYStatusPhotosView : UIView

/**
 *  图片数据（元素是GYPhoto模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  根据图片的数量计算相册的大小
 *
 *  @param photosCount 图片数量
 *
 *  @return 相册大大小
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
