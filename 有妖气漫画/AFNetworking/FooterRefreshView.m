//
//  FooterRefreshView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FooterRefreshView.h"

@implementation FooterRefreshView

- (void)prepare
{
    [super prepare];
    
    //设置正在刷新状态的图片
    NSMutableArray *refreshImgaes = [NSMutableArray array];
    
    for (int i = 0; i < 8; i++ ) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_lu_run%d",i]];
        [refreshImgaes addObject:image];
    }
    
    [self setImages:refreshImgaes forState:MJRefreshStateRefreshing];
}

@end
