//
//  GYComposePhotosView.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYComposePhotosView : UIView

@property (nonatomic, strong) NSArray *images;

/**
 *  添加一张图片到相册内部
 *
 *  @param image 要添加的图片
 */
- (void)addImage:(UIImage *)image;

@end
