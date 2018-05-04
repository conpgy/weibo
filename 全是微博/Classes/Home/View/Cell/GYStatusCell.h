//
//  GYWeiboCell.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-9.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYStatusFrame;

@interface GYStatusCell : UITableViewCell

@property (nonatomic, strong) GYStatusFrame *statusFrame;

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
