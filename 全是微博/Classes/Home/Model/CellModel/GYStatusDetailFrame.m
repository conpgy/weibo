//
//  GYStatusDetailFrame.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusDetailFrame.h"
#import "GYStatusOriginalFrame.h"
#import "GYStatusRetweetedFrame.h"
#import "GYStatus.h"

@implementation GYStatusDetailFrame

-(void)setStatus:(GYStatus *)status
{
    _status = status;
    
    // 设置原创微博的frame
    self.originalFrame = [[GYStatusOriginalFrame alloc] init];
    self.originalFrame.status = self.status;
    
    // 设置转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        self.retweetedFrame = [[GYStatusRetweetedFrame alloc] init];
        self.retweetedFrame.retweetedStatus = self.status.retweeted_status;
        
        // 计算被转发微博的y值
        CGRect f = self.retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(self.originalFrame.frame);
        self.retweetedFrame.frame = f;
        h = CGRectGetMaxY(self.retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(self.originalFrame.frame) ;
    }
    
    // 设置自己的frame
    CGFloat x = 0;
    CGFloat y = GYStatusCellMargin;
    CGFloat w = GYScreenW;
    self.frame = CGRectMake(x, y, w, h);
    
}

@end
