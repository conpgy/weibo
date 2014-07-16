//
//  GYPhoto.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYPhoto.h"

@implementation GYPhoto

+(instancetype)photoWithDict:(NSDictionary *)dict
{
    GYPhoto *photo = [[self alloc] init];
    photo.thumbnail_pic = dict[@"thumbnail_pic"];
    
    return photo;
}

-(void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
