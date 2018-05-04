//
//  GYUnreadCountResult.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYUnreadCountResult.h"

@implementation GYUnreadCountResult

-(int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

-(int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
