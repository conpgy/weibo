//
//  GYOneViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYOneViewController.h"
#import "GYTwoViewController.h"

@interface GYOneViewController ()

@end

@implementation GYOneViewController

- (IBAction)runTo2
{
    GYTwoViewController *threeVc = [[GYTwoViewController alloc] init];
    threeVc.title = @"twoVc";
    
    [self.navigationController pushViewController:threeVc animated:YES];
}

@end
