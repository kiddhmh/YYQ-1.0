//
//  HeadRefreshView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HeadRefreshView.h"

@implementation HeadRefreshView

#pragma mark - 重写方法完成设置
- (void)prepare
{
    [super prepare];
    
    //设置普通状态动画图片
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    UIImage *idleImage = [UIImage imageNamed:@"refresh_lu_jump0"];
    [idleImages addObject:idleImage];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    //设置即将刷新时的图片
    NSMutableArray *pullingImages = [[NSMutableArray alloc] init];
    UIImage *pullingImage = [UIImage imageNamed:@"refresh_lu_f0"];
    [pullingImages addObject:pullingImage];
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    //设置刷新时的动画图片
    NSMutableArray *refreshImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++ ) {
        UIImage *refreshImage = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_lu_f%d",i]];
        [refreshImages addObject:refreshImage];
    }
    [self setImages:refreshImages forState:MJRefreshStateRefreshing];
    
    
    //设置刷新文字
    [self setTitle:@"哟，下拉刷新..." forState:MJRefreshStateIdle];
    [self setTitle:@"哈，松开刷新..." forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    self.stateLabel.textColor = [UIColor darkGrayColor];
    
    //隐藏时间label
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.automaticallyChangeAlpha = YES;
}


@end
