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
//                GYLog(@"一小时前");
                return [NSString stringWithFormat:@"%ld小时前", (long)components.hour];
            } else if (components.minute >= 1) {    // 1~59分钟前发的
//                GYLog(@"1~59分钟");
                return [NSString stringWithFormat:@"%ld分钟前", (long)components.minute];
            } else {    // 一分钟之内发的
//                GYLog(@"刚刚");
                return @"刚刚";
            }
        } else if (createDate.isYesterday) {    // 昨天发的
//                GYLog(@"昨天");
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
        GYLog(@"%@",[formatter stringFromDate:createDate]);
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

@end
