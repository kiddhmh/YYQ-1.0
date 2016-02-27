//
//  JingPingFootView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#define Padding 10
#import "JingPingFootView.h"
#import "UIImageView+WebCache.h"
@interface JingPingFootView ()
@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) UIImageView *imageView3;
@property (nonatomic,strong) UIImageView *imageView4;

@end
@implementation JingPingFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子控件
        CGFloat imageW = 173;
        CGFloat imageH = 85;
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.frame =  CGRectMake(Padding,Padding,imageW,imageH);
        [self addSubview:imageView1];
        self.imageView1 = imageView1;
        
        UIImageView *imageView2 = [[UIImageView alloc] init];
        imageView2.frame = CGRectMake(2 * Padding + imageW,Padding, imageW, imageH);
        [self addSubview:imageView2];
        self.imageView2 = imageView2;
        
        UIImageView *imageView3 = [[UIImageView alloc] init];
        imageView3.frame = CGRectMake(Padding,2 * Padding + imageH, imageW, imageH);
        [self addSubview:imageView3];
        self.imageView3 = imageView3;
        
        UIImageView *imageView4 = [[UIImageView alloc] init];
        imageView4.frame = CGRectMake(2 * Padding + imageW,2 * Padding + imageH, imageW, imageH);
        [self addSubview:imageView4];
        self.imageView4 = imageView4;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imageArray[1]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:imageArray[2]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:imageArray[3]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
}

@end
