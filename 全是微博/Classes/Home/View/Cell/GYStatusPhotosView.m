//
//  GYPhotosView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-16.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusPhotosView.h"
#import "GYStatusPhotoView.h"
#import "GYPhoto.h"

#define GYStatusPhotosMaxCount 9
#define GYStatusPhotoW 70
#define GYStatusPhotoH GYStatusPhotoW
#define GYStatusPhotoMargin 10
#define GYStatusPhotosMaxCols(photosCount) ((photosCount == 4) ? 2 : 3)

@interface GYStatusPhotosView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation GYStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建9个显示图片的photoView
        for (int i = 0; i < GYStatusPhotosMaxCount; i++) {
            GYStatusPhotoView *photoView = [[GYStatusPhotoView alloc] init];
            [self addSubview:photoView];
            
            // 添加点击手势
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoViewDidClick:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

+(CGSize)sizeWithPhotosCount:(int)photosCount
{
    // 每行最大列数
    int maxCol = GYStatusPhotosMaxCols(photosCount);
    
    // 实际列数
    int col = photosCount >= maxCol ? maxCol : photosCount;
    
    // 实际行数
    int row = (photosCount + maxCol - 1) / maxCol;
    
    // 计算尺寸
    CGFloat photosW = GYStatusPhotoW * col + (col - 1) * GYStatusPhotoMargin;
    CGFloat photosH = GYStatusPhotoH * row + (row - 1) * GYStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

#pragma mark - Set方法

-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < self.subviews.count; i++) {
        GYStatusPhotoView *photoView = self.subviews[i];
        if (i >= pic_urls.count) {
            photoView.hidden = YES;
        } else {
            photoView.hidden = NO;
            photoView.photo = pic_urls[i];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = GYStatusPhotosMaxCols(count);
    
    // 计算photoView的尺寸
    for (int i = 0; i < count; i++) {
        GYStatusPhotoView *photoView = self.subviews[i];
        photoView.width = GYStatusPhotoW;
        photoView.height = GYStatusPhotoH;
        photoView.x = (i % maxCols) * (GYStatusPhotoW + GYStatusPhotoMargin);
        photoView.y = (i / maxCols) * (GYStatusPhotoH + GYStatusPhotoMargin);
    }
    
}

#pragma mark - 监听器

- (void)photoViewDidClick:(UITapGestureRecognizer *)tap
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 创建一个蒙版
    UIView *cover = [[UIView alloc] initWithFrame:window.bounds];
    // 设置背景颜色
    cover.backgroundColor = [UIColor blackColor];
    // 设置手势监听器
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverDidTap:)]];
    // 添加到窗口中
    [window addSubview:cover];
    
    // 将被点击的图片添加到蒙版上
    GYStatusPhotoView *photoView = (GYStatusPhotoView *)tap.view;
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
    // 设置坐标
    imageView.frame = [cover convertRect:photoView.frame fromView:self];
    [cover addSubview:imageView];
    self.imageView = imageView;
    self.lastFrame = imageView.frame;
    
    // 放大图片
    CGRect frame = imageView.frame;
    frame.size.width = cover.width;
    frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
    frame.origin.x = 0;
    frame.origin.y = (cover.height - frame.size.height) * 0.5;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.frame = frame;
    }];
}

- (void)coverDidTap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.4 animations:^{
        tap.view.backgroundColor = [UIColor clearColor];
        self.imageView.frame = self.lastFrame;
    } completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
        self.imageView = nil;
    }];
}

@end
