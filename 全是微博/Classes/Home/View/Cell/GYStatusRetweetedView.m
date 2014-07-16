//
//  GYStatusRetweetedView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusRetweetedView.h"
#import "GYStatusRetweetedFrame.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYStatusPhotosView.h"

@interface GYStatusRetweetedView()

/**
 *  配图相册
 */
@property (nonatomic, weak) GYStatusPhotosView *photosView;

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation GYStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 设置自己的背景图片
        [self setImage:[UIImage resizedImage:@"timeline_retweet_background"]];
        
        // 1. 创建昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = GYStatusRetweetedNameFont;
        nameLabel.textColor = GYColor(74, 102, 105);
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2. 创建正文
        UILabel *textLabel =[[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = GYStatusRetweetedTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 添加配图相册
        GYStatusPhotosView *photosView = [[GYStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

-(void)setRetweetedFrame:(GYStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    GYStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    GYUser *user = retweetedStatus.user;
    
    // 设置昵称
    self.nameLabel.frame = retweetedFrame.nameFrame;
    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    
    // 设置正文
    self.textLabel.frame = retweetedFrame.textFrame;
    self.textLabel.text = retweetedStatus.text;
    
    // 设置配图相册
    if (retweetedStatus.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
}

@end
