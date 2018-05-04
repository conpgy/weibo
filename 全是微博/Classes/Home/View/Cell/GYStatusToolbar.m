//
//  GYStatusToolbar.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusToolbar.h"
#import "GYStatus.h"

@interface GYStatusToolbar ()

@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;

@end

@interface GYStatusToolbar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation GYStatusToolbar

#pragma mark - 懒加载

-(NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

-(NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    
    return _dividers;
}

#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景图片
        self.image = [UIImage resizedImage:@"timeline_card_bottom_background"];
        // 设为能交互
        self.userInteractionEnabled = YES;
        
        // 添加三个转发、评论、赞这个三个按钮
        self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentsBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudesBtn = [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
        
        // 添加两根分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

#pragma mark - 自定义

/**
 *  添加按钮
 *
 *  @param iconName 按钮图标名
 *  @param title    按钮标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)iconName title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = GYStatusOriginalTextFont;
    [button setImage:[UIImage imageWithName:iconName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 设置图标与标题间的间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 设置高亮时的背景图片
    [button setBackgroundImage:[UIImage resizedImage:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted =  NO;
    
    [self.btns addObject:button];
    [self addSubview:button];
    
    return button;
}

/**
 *  添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.contentMode = UIViewContentModeCenter;
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    
    [self.dividers addObject:divider];
    [self addSubview:divider];
}

#pragma mark - 子控件重新布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算按钮的frame
    int btnCount = self.btns.count;
    CGFloat buttonW = self.width / btnCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *button = self.btns[i];
        button.x = i * buttonW;
        button.y = 0;
        button.size = CGSizeMake(buttonW, buttonH);
    }
    
    // 计算divider的frame
    int dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 4;
        divider.height = self.height;
        divider.center = CGPointMake(buttonW * (i+1), self.height * 0.5);
    }
}

-(void)setStatus:(GYStatus *)status
{
    _status = status;
    
    [self setupBtnTitle:self.repostsBtn count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentsBtn count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.attitudesBtn count:status.attitudes_count defaultTitle:@"赞"];
}

/**
 *  设置按钮文字
 */
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    NSString *title = defaultTitle;
    if (count >= 10000) {
        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        title = [NSString stringWithFormat:@"%d", count];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

@end
