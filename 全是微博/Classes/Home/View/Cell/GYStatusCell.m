//
//  GYWeiboCell.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYStatusCell.h"
#import "GYStatus.h"
#import "GYUser.h"
#import "GYStatusFrame.h"
#import "GYPhoto.h"
#import "GYStatusDetailView.h"
#import "GYStatusToolbar.h"
#import "GYStatusDetailFrame.h"

@interface GYStatusCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *introLabel;
@property (nonatomic, weak) UIImageView *pictureView;

@property (nonatomic, weak) GYStatusDetailView *detailView;
@property (nonatomic, weak) GYStatusToolbar *toolbar;


@end

@implementation GYStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 清空cell的颜色
        self.backgroundColor = [UIColor clearColor];
        
        // 添加detailView
        GYStatusDetailView *detailView = [[GYStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 添加工具条
        GYStatusToolbar *toolbar = [[GYStatusToolbar alloc] init];
        // 设置背景图片
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

+(instancetype)statusCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"statusCell";
    
    GYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[GYStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

-(void)setStatusFrame:(GYStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置detailView的frame
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 设置toolbar的frame
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
}
@end
