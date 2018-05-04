//
//  GYStatusOriginalFrame.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-14.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusOriginalFrame.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYStatusPhotosView.h"

@implementation GYStatusOriginalFrame

-(void)setStatus:(GYStatus *)status
{
    _status = status;
    
    // 设置头像的frame
    CGFloat iconX = GYStatusCellInset;
    CGFloat iconY = GYStatusCellInset;
    CGFloat iconW = 40;
    CGFloat iconH = iconW;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 设置昵称的frame
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + GYStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:GYStatusOriginalNameFont];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 设置vip图标的frame
    CGFloat vipX = CGRectGetMaxX(self.nameFrame) + GYStatusCellInset;
    CGFloat vipY = nameY;
    CGFloat vipW = nameH;
    CGFloat vipH = vipW;
    self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    // 设置正文的frame
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + GYStatusCellInset;
    CGSize maxSize = CGSizeMake(GYScreenW - 2 * textX, MAXFLOAT);
    CGSize textSize = [status.attributeText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 设置配图相册的frame
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + GYStatusCellInset;
        CGSize photosSize = [GYStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
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
