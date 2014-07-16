//
//  GYLoadMoreFooter.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-10.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYLoadMoreFooter.h"

@interface GYLoadMoreFooter ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation GYLoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GYLoadMoreFooter" owner:nil options:nil] lastObject];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GYLoadMoreFooter" owner:nil options:nil] lastObject];
    }
    
    return self;
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}



@end
