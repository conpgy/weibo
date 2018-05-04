//
//  GYTitleButton.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-4.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYTitleButton.h"

@implementation GYTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        // 设置字体型号和大小
        self.titleLabel.font = GYNavigationTitleFont;
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 高亮状态不调整图片的颜色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
    // 计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
    
}

@end
