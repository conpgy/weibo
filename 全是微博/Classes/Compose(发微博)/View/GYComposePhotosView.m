//
//  GYComposePhotosView.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-11.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYComposePhotosView.h"

@implementation GYComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

-(NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    
    return array;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    unsigned  long int count = self.subviews.count;
    
    int maxCol = 4;
    
    CGFloat margin = 10;
    
    CGFloat imageViewW = (self.width - margin * (maxCol + 1)) / maxCol;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i < count; i++) {
        int col = i % maxCol;
        int row = i / maxCol;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.x = margin + col * (imageViewW + margin);
        imageView.y = row * (imageViewH + margin);
        
    }
}

@end
