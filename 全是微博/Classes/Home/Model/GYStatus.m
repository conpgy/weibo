//
//  GYStatus.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatus.h"
#import "GYUser.h"
#import "GYPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "GYRegexResult.h"
#import "GYEmotionAttachment.h"
#import "GYEmotionTool.h"
#import "GYEmotion.h"

@implementation GYStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [GYPhoto class]};
}

-(NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
//    GYLog(@"created_at: %@", _created_at);
#warning 在真机上测试返回null
    NSDate *createDate = [formatter dateFromString:_created_at];
//    GYLog(@"createDate: %@", createDate);
    
    // 判断是否为今年发布的
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            NSDateComponents *components = [createDate deltaWithNow];
            if (components.hour >= 1) { // 至少一小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)components.hour];
            } else if (components.minute >= 1) {    // 1~59分钟前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)components.minute];
            } else {    // 一分钟之内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) {    // 昨天发的
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createDate];
    }
}

-(void)setSource:(NSString *)source
{
    _source = source;
    
    NSRange range;
    // 字符串截取范围
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 截取字符串
    NSString *subSource = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@", subSource];
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    
    // 将带有表情描述的普通文本转换为富文本
    self.attributeText = [self attributeTextFromText:text];
}

/**
 *  普通文本转换为富文本
 */
- (NSAttributedString *)attributeTextFromText:(NSString *)text
{
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    
    // 根据本文计算出匹配结果
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 根据匹配结果拼接文本
    [regexResults enumerateObjectsUsingBlock:^(GYRegexResult *regexResult, NSUInteger idx, BOOL *stop) {
        if (regexResult.isEmotion) {    // 表情
            GYEmotionAttachment *attachment = [[GYEmotionAttachment alloc] init];
            attachment.emotion = [GYEmotionTool emotionWithDesc:regexResult.string];
            attachment.bounds = CGRectMake(0, -3, GYStatusOriginalTextFont.lineHeight, GYStatusOriginalTextFont.lineHeight);
            NSAttributedString *subStr = [NSAttributedString attributedStringWithAttachment:attachment];
            
            [attributeText appendAttributedString:subStr];
        } else {    // 非表情, 普通文本
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc] initWithString:regexResult.string];
            
            // 匹配转发、话题、超链接，进行颜色设置
            // 匹配#话题#
            NSString *topicRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [subStr.string enumerateStringsMatchedByRegex:topicRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:GYStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配@
            NSString *metionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?";
            [subStr.string enumerateStringsMatchedByRegex:metionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:GYStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [subStr.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:GYStatusHighTextColor range:*capturedRanges];
            }];
            
            [attributeText appendAttributedString:subStr];
        }
    }];
    
    
    // 设置字体
    [attributeText addAttribute:NSFontAttributeName value:GYStatusOriginalTextFont range:NSMakeRange(0, attributeText.length)];
    
    return attributeText;
}

/**
 *  根据文本计算出匹配结果
 *
 *  @param text 文本
 *
 *  @return 匹配结果数组
 */
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 存储匹配结果
    NSMutableArray *results = [NSMutableArray array];
    
    // 设置表情匹配格式
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    //遍历文本，根据表情格式匹配表情
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        GYRegexResult *regexR = [[GYRegexResult alloc] init];
        regexR.string = *capturedStrings;
        regexR.range = *capturedRanges;
        regexR.emotion = YES;
        
        [results addObject:regexR];
    }];
    
    //遍历文本，根据表情格式匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        GYRegexResult *regexR = [[GYRegexResult alloc] init];
        regexR.string = *capturedStrings;
        regexR.range = *capturedRanges;
        regexR.emotion = NO;
        
        [results addObject:regexR];
    }];
    
    // 对匹配结果进行排序,(根据range的location，从小到大)
    [results sortUsingComparator:^NSComparisonResult(GYRegexResult *r1, GYRegexResult *r2) {
        int loc1 = r1.range.location;
        int loc2 = r2.range.location;
        
        return [@(loc1) compare:@(loc2)];
    }];
    
    return results;
}

@end
