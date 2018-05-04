//
//  GYBaseParam.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYBaseParam.h"
#import "GYAccount.h"
#import "GYAccountTool.h"

@implementation GYBaseParam

-(id)init
{
    if (self = [super init]) {
        self.access_token = [GYAccountTool account].access_token;
    }
    
    return self;
}

+(instancetype)param
{
    return [[self alloc] init];
}

@end
