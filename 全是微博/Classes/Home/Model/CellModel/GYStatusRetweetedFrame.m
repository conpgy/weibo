//
//  GYStatusRetweetedFrame.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusRetweetedFrame.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYStatusPhotosView.h"

@implementation GYStatusRetweetedFrame

-(void)setRetweetedStatus:(GYStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 设置昵称的frame
    CGFloat nameX = GYStatusCellInset;
    CGFloat nameY = GYStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:GYStatusRetweetedNameFont];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 设置正文的frame
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + GYStatusCellInset;
    CGSize maxSize = CGSizeMake(GYScreenW - 2 * textX, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:GYStatusRetweetedTextFont constrainedToSize:maxSize];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 设置配图相册的frame
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + GYStatusCellInset;
        CGSize photosSize = [GYStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + GYStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + GYStatusCellInset;
    }
    
    // 设置自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = GYScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
