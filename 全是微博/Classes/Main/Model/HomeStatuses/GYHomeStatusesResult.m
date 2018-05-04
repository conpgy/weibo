//
//  GYHomeStatusesResult.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYHomeStatusesResult.h"
#import "MJExtension.h"
#import "GYStatusFrame.h"
#import "GYStatus.h"

@implementation GYHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses": [GYStatus class]};
}

@end
