//
//  GYUser.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYUser.h"
#import "GYAccount.h"
#import "GYAccountTool.h"

@implementation GYUser

-(BOOL)isVip
{
    return self.mbtype > 2;
}

@end
