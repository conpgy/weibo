//
//  GYHomeViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYHomeViewController.h"
#import "GYOneViewController.h"
#import "GYTitleButton.h"
#import "GYPopMenu.h"
#import "GYAccount.h"
#import "GYAccountTool.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYUserTool.h"
#import "GYStatusCell.h"
#import "GYStatusFrame.h"
#import "GYLoadMoreFooter.h"
#import "GYStatusTool.h"
#import "GYHomeStatusesParam.h"
#import "GYHomeStatusesResult.h"
#import "GYUserInfoParam.h"
#import "GYUserInfoResult.h"

@interface GYHomeViewController ()<GYPopMenuDelegate>

@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (nonatomic, weak) UIRefreshControl *refreshControl;

@property (nonatomic, weak) GYLoadMoreFooter *footerView;

@property (nonatomic, weak) UIButton *titleBtn;



@end

@implementation GYHomeViewController

#pragma mark - 懒加载
-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GYColor(211, 211, 211);
    
    // 设置导航栏内容
    [self setupNavBar];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 获取用户信息
    [self setupUserInfo];
}

/**
 *  获取用户信息
 */
- (void)setupUserInfo
{
    // 封装请求参数
    GYUserInfoParam *param = [GYUserInfoParam param];
    param.uid = [GYAccountTool account].uid;
    
    // 获取用户信息
    [GYUserTool userInfoWithParam:param success:^(GYUserInfoResult *user) {
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        // 存储账户信息
        GYAccount *account = [GYAccountTool account];
        account.name = user.name;
        [GYAccountTool save:account];
        
    } failure:^(NSError *error) {
        GYLog(@"获取用户信息失败：%@", error);
    }];
}

/**
 *  集成刷新控件
 */

- (void)setupRefresh
{
    // 添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    // 设置监听器
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // 让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 加载数据
    [self refresh:refreshControl];
    
    // 添加上拉加载更多控件
    GYLoadMoreFooter *footerView = [GYLoadMoreFooter footer];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    // 加载新的微博数据
    [self loadNewStatuses];
}

/**
 *  加载最新的微博数据
 */

- (void)loadNewStatuses
{
    // 设置参数信息
    GYHomeStatusesParam *param = [[GYHomeStatusesParam alloc] init];
    param.access_token = [GYAccountTool account].access_token;
    
    GYStatusFrame *statusFrame = [self.statusFrames firstObject];
    if (statusFrame) {
        param.since_id = statusFrame.status.idstr;
    }
    
    // 加载首页微博
    [GYStatusTool homeStatusesWithParam:param success:^(GYHomeStatusesResult *result) {
        // 让刷新控件停止刷新
        [self.refreshControl endRefreshing];
        
        [MBProgressHUD hideHUD];
        
        NSArray *newStatusFrames = [self statusFramesWithStatuses:result.statuses];
        
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newStatusFrames.count];
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUD];
        GYLog(@"%@", error);
    }];
}

/**
 *  将微博数组转换为微博frame模型数组
 *
 *  @param statuses 微博数组
 *
 *  @return 微博frame数组
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *newStatusFrames = [NSMutableArray arrayWithCapacity:statuses.count];
    for (GYStatus *status in statuses) {
        GYStatusFrame *statusFrame = [[GYStatusFrame alloc] init];
        statusFrame.status = status;
        [newStatusFrames addObject:statusFrame];
    }
    
    return newStatusFrames;
}

/**
 *  加载更多微博数据
 */

- (void)loadMoreStatuses
{
    // 设置参数信息
    GYHomeStatusesParam *param = [[GYHomeStatusesParam alloc] init];
    param.access_token = [GYAccountTool account].access_token;
    GYStatusFrame *statusFrame = [self.statusFrames lastObject];
    if (statusFrame) {
        param.max_id = statusFrame.status.idstr;
    }
    
    // 加载更多微博
    [GYStatusTool homeStatusesWithParam:param success:^(GYHomeStatusesResult *result) {
        // 让刷新控件停止刷新
        [self.footerView endRefreshing];
        
        [MBProgressHUD hideHUD];
        
        NSArray *newStatusFrames = [self statusFramesWithStatuses:result.statuses];
        
        [self.statusFrames addObjectsFromArray:newStatusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUD];
        GYLog(@"%@", error);
    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 新微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    UILabel *label = [[UILabel alloc] init];
    
    // 设置frame
    label.x = 0;
    label.width = self.view.width;
    label.height = 35;
    label.y = 64 - label.height;
    
    // 设置文字
    if (count) {
        label.text = [NSString stringWithFormat:@"%d条新微博", count];
    } else {
        label.text = @"没有新微博";
    }
    // 设置文字居中
    label.textAlignment = NSTextAlignmentCenter;
    
    // 设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    
    // 添加到导航控制器的view中
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 设置动画
//    label.hidden = YES;
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    GYTitleButton *titleBtn = [[GYTitleButton alloc] init];
    self.titleBtn = titleBtn;
    titleBtn.height = 35;
    NSString *name = [GYAccountTool account].name;
    [titleBtn setTitle:name ? name : @"首页首页首页首页首页首页首页首页首页首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置监听器
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
}

- (void)titleBtnClick:(UIButton *)button
{
    [button setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    GYPopMenu *menu = [GYPopMenu popMenuWithContentView:nil];
    menu.delegate = self;
    [menu showInRect:CGRectMake(55, 55, 200, 100)];
}


- (void)friendSearch
{
    GYOneViewController *oneVc = [[GYOneViewController alloc] init];
    oneVc.title = @"oneVc";
    
    [self.navigationController pushViewController:oneVc animated:YES];
}

- (void)pop
{
    GYLog(@"hahha");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footerView.hidden = self.statusFrames.count == 0;
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    GYStatusCell *cell = [GYStatusCell statusCellWithTableView:tableView];
    
    // 设置数据
    cell.statusFrame = statusFrame;
    
    return cell;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] cellHight];
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footerView.isRefreshing ) return;
    
    // 差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footerView的高度
    CGFloat savFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    if (delta <= savFooterH) {
        [self.footerView beginRefreshing];
        [self loadMoreStatuses];
    }
}

#pragma mark - GYPopMenuDelegate

-(void)popMenuDidDismissed:(GYPopMenu *)popMenu
{
    GYTitleButton *titleBtn = (GYTitleButton *)self.navigationItem.titleView;
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

@end
