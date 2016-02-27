//
//  LoadingView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView ()

///缓冲动画图片数组
@property (nonatomic,strong) NSMutableArray *loadImage;
///播放动画的ImageView
@property (nonatomic,strong) UIImageView *loadImageView;

@end
@implementation LoadingView

- (NSMutableArray *)loadImage
{
    if (_loadImage == nil) {
        _loadImage = [[NSMutableArray alloc]init];
    }
    return _loadImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}




- (void)showLoadingTo:(UIView *)view
{
    self.backgroundColor = [UIColor whiteColor];
    //播放加载动画
    [self creatLoadImage];
    
    [view addSubview:self];
}

- (void)showLoadViewTo:(UIWindow *)window
{
    self.backgroundColor = [UIColor whiteColor];
    //播放加载动画
    [self creatLoadImage];
    
    [window addSubview:self];
}

#pragma mark - 播放加载动画
- (void)creatLoadImage
{
    
    //创建显示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(135, 460,100,30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"玩命加载中...";
    [self addSubview:label];
    
    //创建图片动画
    self.loadImageView = [[UIImageView alloc] init];
    CGRect rect = CGRectMake(self.center.x - 80,self.center.y - 130,160,260);
    self.loadImageView.frame = rect;
    
    [self addSubview:self.loadImageView];
    
    //加载图片
    if (self.loadImage.count == 0) {
        for (int i = 1; i < 51; i++ ) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [self.loadImage addObject:image];
        }
    }
    
    //设置动画
    self.loadImageView.animationImages = self.loadImage;
    self.loadImageView.animationRepeatCount = 0;
    self.loadImageView.animationDuration = 4;
    
    [self.loadImageView startAnimating];
}

///停止动画
- (void)dismiss
{
    self.loadImage = nil;
    self.loadImageView.animationImages = nil;
    [self.loadImageView removeFromSuperview];
    [self removeFromSuperview];
}

@end
