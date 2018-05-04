//
//  GYTwoViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYTwoViewController.h"
#import "GYThreeViewController.h"

@interface GYTwoViewController ()

@end

@implementation GYTwoViewController

- (IBAction)runTo3
{
    GYThreeViewController *threeVc = [[GYThreeViewController alloc] init];
    threeVc.title = @"threeVc";
    
    [self.navigationController pushViewController:threeVc animated:YES];
}


@end
