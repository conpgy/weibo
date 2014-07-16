//
//  GYPopMenu.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-4.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYPopMenu.h"

@interface GYPopMenu ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *cover;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation GYPopMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 创建菜单图片
        UIImageView *container = [[UIImageView alloc] init];
        container.image = [UIImage resizedImage:@"popover_background"];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        self.container = container;
    }
    return self;
}

-(instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    
    return self;
}

+(instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

-(void)showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置contentView的frame
    CGFloat topMargin = 13;
    CGFloat leftMargin = 5;
    CGFloat bottomMargin = 9;
    CGFloat rightMargin = 5;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

- (void)coverClick
{
    [self dismiss];
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
    
    [self removeFromSuperview];
}

@end
