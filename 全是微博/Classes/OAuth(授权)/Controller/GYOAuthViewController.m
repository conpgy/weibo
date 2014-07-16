//
//  GYOAuthViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "GYControllerTool.h"
#import "GYAccount.h"
#import "GYAccountTool.h"
#import "GYAccessTokenParam.h"

@interface GYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation GYOAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;

    // 2. 加载登录页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4216551050&redirect_uri=http://conpgy.github.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 3. 设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    GYLog(@"error = %@", error);
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获得请求地址
    NSString *url = request.URL.absoluteString;
    
    // 判断url是否为回调地址
    NSRange range = [url rangeOfString:@"http://conpgy.github.com/?code="];
    if (range.location != NSNotFound) {
        // 截取授权成功后的请求标记
        int from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回掉页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 封装请求参数
    GYAccessTokenParam *param = [[GYAccessTokenParam alloc] init];
    param.client_id = GYAppKey;
    param.client_secret = GYAppSecret;
    param.redirect_uri = GYRedirectURI;
    param.grant_type = @"authorization_code";
    param.code = code;
    
    // 获得accessToken
    [GYAccountTool accessTokenWithParam:param success:^(GYAccount *account) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        // 存储帐号模型
        [GYAccountTool save:account];
        
        // 切换控制器
        [GYControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        GYLog(@"请求失败：%@", error);
    }];
}

@end
