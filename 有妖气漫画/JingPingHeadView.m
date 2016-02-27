//
//  JingPingHeadView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "JingPingHeadView.h"
#import "UIImageView+WebCache.h"
#import "MyImageView.h"
@interface JingPingHeadView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

@end
@implementation JingPingHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //初始化ScrollerView
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        
        [self addSubview:self.scrollView];
        
        
        //初始化pageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150,130,75,10)];
        self.pageControl.currentPage = 0;
        
        [self addSubview:self.pageControl];
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    CGFloat imageY = 0;
    CGFloat imageW = self.scrollView.frame.size.width ;
    CGFloat imageH = self.scrollView.frame.size.height;
    
    for (int i = 0; i < imageArray.count; i++ ) {

        UIImage *imageGet = [UIImage imageWithData:imageArray[i]];

        MyImageView *imageView = [[MyImageView alloc] initWithFrame:CGRectMake(imageW * i,imageY, imageW, imageH)];
        
        imageView.image = imageGet;
        
        [self.scrollView insertSubview:imageView atIndex:0];
    }
    self.scrollView.contentSize = CGSizeMake(imageW * imageArray.count, 0);
    
    self.pageControl.numberOfPages = imageArray.count;
    
    //创建定时器
    [self addtimer];
    
}

#pragma mark - 创建定时器
- (void)addtimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark - 跳转下一页
- (void)nextImage
{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.imageArray.count - 1) {
        page = 0;
    }else
    {
        page ++;
    }
    
    CGPoint newOffset = CGPointMake(page * self.scrollView.frame.size.width, 0);
    
    [self.scrollView setContentOffset:newOffset animated:YES];
}

#pragma mark - UIScrollerViewDelegate
//确定当前页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet = self.scrollView.contentOffset;
    CGFloat offX = offSet.x;
    CGFloat ScrollW = self.scrollView.frame.size.width;
    
    self.pageControl.currentPage = (offX + 0.5*ScrollW) / ScrollW;
}


//拖动时移除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

//开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addtimer];
}


@end
