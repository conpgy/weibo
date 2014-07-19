//
//  GYEmotionTextView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-18.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYEmotionTextView.h"
#import "GYEmotion.h"

@implementation GYEmotionTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)appendEmotion:(GYEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.emoji];
    } else {
        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        NSString *name = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        attachment.image = [UIImage imageWithName:name];
        attachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *emotionStr = [NSMutableAttributedString attributedStringWithAttachment: attachment];
        
        // 记录表情的插入位置
        int insertIndex = self.selectedRange.location;
        // 插入表情到光标所在的位置
        [attributeText insertAttributedString:emotionStr atIndex:insertIndex];
        
        // 设置字体
        [attributeText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributeText.length)];
        
        self.attributedText = attributeText;
        
    }
    
}

@end
