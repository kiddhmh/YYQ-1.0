//
//  MainView.m
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainUI];

    }
    return self;
}

- (void)createMainUI
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    

    [self addSubview:self.scrollView];
    
}

@end
