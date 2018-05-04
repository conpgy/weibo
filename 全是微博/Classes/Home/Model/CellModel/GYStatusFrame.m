//
//  GYWeibo.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusFrame.h"
#import "GYStatus.h"
#import "GYStatusDetailFrame.h"
#import "GYStatusToolbar.h"

@implementation GYStatusFrame

-(void)setStatus:(GYStatus *)status
{
    _status = status;
    
    // 计算微博具体内容的frame
    [self setupDetailFrame];
    
    // 设置工具条的frame
    [self setupToolbarFrame];
    
    // 设置cell的高度
    self.cellHight = CGRectGetMaxY(self.toolbarFrame);
}

- (void)setupDetailFrame
{
    self.detailFrame = [[GYStatusDetailFrame alloc] init];
    self.detailFrame.status = self.status;
}

- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = GYScreenW;
    CGFloat toolBarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolBarH);
    
}

- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size;
}

@end
