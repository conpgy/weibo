//
//  GYDetailView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusDetailView.h"
#import "GYStatusOriginalView.h"
#import "GYStatusRetweetedView.h"
#import "GYStatusDetailFrame.h"

@interface GYStatusDetailView ()

@property (nonatomic, weak) GYStatusOriginalView *originalView;
@property (nonatomic, weak) GYStatusRetweetedView *retweetedView;

@end

@implementation GYStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置image
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        // 添加原创微博
        GYStatusOriginalView *originalView = [[GYStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 添加转发微博
        GYStatusRetweetedView *retweetedView = [[GYStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

-(void)setDetailFrame:(GYStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 设置原创微博的frame和转发微博的frame
    self.originalView.originalFrame = detailFrame.originalFrame;
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
    
}

@end
