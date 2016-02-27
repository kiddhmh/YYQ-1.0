//
//  SreachView.m
//  有妖气漫画——搜索
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "SreachView.h"

@implementation SreachView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    
    // 搜索栏Button
    
    UIButton *searchBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBarBtn.frame = CGRectMake(45, 50, 237, 30);
    [searchBarBtn addTarget:self action:@selector(gotoSSView) forControlEvents:UIControlEventTouchUpInside];
    
    
    [searchBarBtn setImage:[UIImage imageNamed:@"searchVCtextfield"] forState:UIControlStateNormal];
    [self addSubview:searchBarBtn];
    
    // 搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(302, 50, 38, 30);
    searchBarBtn.backgroundColor = [UIColor brownColor];
    
    [searchBtn setImage:[UIImage imageNamed:@"search1"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"search_hightlight"] forState:UIControlStateHighlighted];
    
    [self addSubview:searchBtn];
    
    // 热门搜索图片
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, 5, 30)];
    imageView.image = [UIImage imageNamed:@"searchSX"];
    [self addSubview:imageView];
    
    // 热门搜索标签
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 200, 30)];
    searchLabel.text = @"热门搜索";
    searchLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:searchLabel];
    
    // 热门搜索下的线
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, self.bounds.size.width, 1)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
    
    
    // ScrollView
    
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 170, 345, 490)];
    
    
#pragma mark -
    
    // 滚动视图不可见
    scollView.contentSize = CGSizeMake(0, 490);
    // 偏移
    scollView.contentOffset = CGPointMake(0,-10);
    scollView.contentInset = UIEdgeInsetsMake(10, 0, 45, 0);
    scollView.showsVerticalScrollIndicator = NO;
    
    
    [self addSubview:scollView];
    
    
    
    // 集合视图布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //创建集合视图 ，设置代理
    
    self.VC_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, 335, 485) collectionViewLayout:layout];
    
    self.VC_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    [scollView addSubview:self.VC_collectionView];


}


- (void)passBlock:(Block)tempBlock
{
    self.block = tempBlock;
}

#pragma mark - 跳转到下一个界面
- (void)gotoSSView
{
    self.block();
}

@end
