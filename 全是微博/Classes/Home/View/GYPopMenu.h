//
//  GYPopMenu.h
//  全是微博
//
//  Created by 彭根勇 on 14-7-4.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYPopMenu;

@protocol GYPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(GYPopMenu *)popMenu;
@end

@interface GYPopMenu : UIView

- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

- (void)showInRect:(CGRect)rect;

@property (nonatomic, weak) id<GYPopMenuDelegate> delegate;


@end
