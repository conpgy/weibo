//
//  GYDiscoverViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-3.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYDiscoverViewController.h"
#import "GYSearchBar.h"

@interface GYDiscoverViewController ()

@end

@implementation GYDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GYSearchBar *searchBar = [GYSearchBar searchBar];
    searchBar.size = CGSizeMake(300, 35);
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Table view delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.navigationController.view endEditing:YES];
}

@end
