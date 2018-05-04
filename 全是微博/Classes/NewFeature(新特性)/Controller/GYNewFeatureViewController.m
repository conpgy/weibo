//
//  GYNewFeatureViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYNewFeatureViewController.h"
#import "GYTabBarController.h"

#define FeatureImageCount 4

@interface GYNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation GYNewFeatureViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加scrollView用图片展示新特性
    [self setupScrollView];
    
    // 添加pageControl
    [self setupPageControl];
    
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    // 设置scrollView属性
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(FeatureImageCount * self.view.width, self.view.height);
    
    self.scrollView = scrollView;
    
    // 添加图片
    for (int i = 0; i < FeatureImageCount; i++) {
        // 设置frame
        CGFloat width = self.view.width;
        CGFloat height = self.view.height;
        CGFloat x = i * width;
        CGFloat y = 0;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        // 判断是否是4英寸
        if (FourInch) {
            imageName = [imageName stringByAppendingString:@"-568h"];
        }
        
        imageView.image = [UIImage imageWithName:imageName];
        [scrollView addSubview:imageView];
        
        // 如果是最后一张图片，则添加进入微博首页的按钮
        if (i == FeatureImageCount - 1) {
            [self addEnterBtnInImageView:imageView];
        }
    }
}

/**
 *  在最后一个imageView上添加进入微博首页的按钮
 */
- (void)addEnterBtnInImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1. 添加开始按钮
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    button.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.8);
    [imageView addSubview:button];
    
    // 设置监听器
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    // 2. 添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.7);
    
    // 设置图片和文字的间距
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

/**
 *  开始微博
 */
- (void)start
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GYTabBarController *tabBar = [[GYTabBarController alloc] init];
    window.rootViewController = tabBar;
}

/**
 *  监听分享按钮点击
 */
- (void)share:(UIButton * )shareButton
{
    shareButton.selected = !shareButton.isSelected;
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = FeatureImageCount;
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 30);
    
    pageControl.currentPageIndicatorTintColor = GYColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = GYColor(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double doublePage = scrollView.contentOffset.x / scrollView.width;
    int currentPage = (int)(doublePage + 0.5);
    self.pageControl.currentPage = currentPage;
}

@end
