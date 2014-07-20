//
//  GYStatusOriginalView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusOriginalView.h"
#import "GYStatusOriginalFrame.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYStatusPhotosView.h"

@interface GYStatusOriginalView ()

/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  vip图标
 */
@property (nonatomic, weak) UIImageView *vipView;

/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

/**
 *  微博来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;

/**
 *  配图相册
 */
@property (nonatomic, weak) GYStatusPhotosView *photosView;

@end

@implementation GYStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 创建头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 2. 创建昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = GYStatusOriginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 3. 创建VIP图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 4. 创建正文
        UILabel *textLabel =[[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = GYStatusOriginalTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 创建时间标签
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
        timeLabel.font = GYStatusOriginalTimeFont;
        
        // 创建来源标签
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = GYStatusOriginalSourceFont;
        sourceLabel.textColor = GYColor(211, 211, 211);
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 添加配图相册
        GYStatusPhotosView *photosView = [[GYStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

/**
 *  设置frame
 */
-(void)setOriginalFrame:(GYStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    GYStatus *status = originalFrame.status;
    // 取出用户数据
    GYUser *user = status.user;
    
    // 设置头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    // 设置昵称
    self.nameLabel.frame = originalFrame.nameFrame;
    self.nameLabel.text = user.name;
    
    // 设置VIP图标
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.vipView.hidden = YES;
        
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 设置正文
    self.textLabel.frame = originalFrame.textFrame;
    self.textLabel.attributedText = status.attributeText;
    
    // 设置时间
    // 根据当前时间计算timeLabel的frame
    NSString *time = status.created_at;
    self.timeLabel.text = time;
    // 设置时间的frame
    self.timeLabel.x = self.nameLabel.x;
    self.timeLabel.y = CGRectGetMaxY(self.nameLabel.frame) + GYStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:GYStatusOriginalTimeFont];
    self.timeLabel.width = timeSize.width;
    self.timeLabel.height = timeSize.height;
    
    // 设置来源
    NSString *soucre = status.source;
    self.sourceLabel.text = soucre;
    
    // 设置自己的frame
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + GYStatusCellInset;
    CGFloat sourceY = self.timeLabel.y;
    CGSize sourceSize = [soucre sizeWithFont:GYStatusOriginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 设置配图相册
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
}

@end
