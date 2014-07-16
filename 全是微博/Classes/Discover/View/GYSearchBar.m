//
//  GYSearchBar.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-4.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYSearchBar.h"

@implementation GYSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIImageView *searchView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        searchView.contentMode = UIViewContentModeCenter;
        searchView.size = CGSizeMake(searchView.image.size.width + 10, searchView.image.size.height + 10);
        self.leftView = searchView;
        
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
