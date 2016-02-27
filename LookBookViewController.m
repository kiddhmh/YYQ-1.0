//
//  LookBookViewController.m
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "LookBookViewController.h"

#import "HeadView.h"
#import "FootView.h"
#import "MainView.h"

#import "OrangeBaseNetWorking.h"
#import "LookBookDatamodel.h"
#import "UIImageView+WebCache.h"

#import "LoadingView.h"

@interface LookBookViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) HeadView *headView;
@property (strong, nonatomic) FootView *footView;
@property (strong, nonatomic) MainView *mainView;
@property (strong, nonatomic) LookBookDatamodel *lookBook;

@property (nonatomic,strong) LoadingView *waitView;


@end
@implementation LookBookViewController

- (void)setUrlStr:(NSString *)urlStr
{
    if (_urlStr != urlStr) {
        _urlStr = urlStr;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    self.headView.hidden = YES;
    self.footView.hidden = YES;
    
    //播放加载动画
    self.waitView = [[LoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.waitView showLoadViewTo:[UIApplication sharedApplication].keyWindow];
    
    self.lookBook = [[LookBookDatamodel alloc] init];
    self.headView.titleLabel.text = self.titleStr;
    
    // 获取数据
    [self receiveNetWorkingData];
    
   // 点击按钮
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMethod)];
    [self.view addGestureRecognizer:tap];
    
    //  headView中进度条关联事件
    [self.headView.slider addTarget:self action:@selector(sliderMethod) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - -----------------------创建UI---------------------

- (void)createUI
{
    // 主视图
    
    self.mainView = [[MainView alloc] initWithFrame:self.view.bounds];
    self.mainView.scrollView.delegate = self;
    [self.view addSubview:self.mainView];
    
    
    // 头视图
    self.headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, 375, 65)];
    self.headView.backgroundColor = [UIColor blackColor];
    self.headView.alpha = 0.6;
    self.headView.titleLabel.text = self.title;
    [self.headView.backBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headView];
    
    // 尾视图
    self.footView = [[FootView alloc] initWithFrame:CGRectMake(0, 571, 375, 96)];
    self.footView.backgroundColor = [UIColor blackColor];
    self.footView.alpha = 0.6;
    [self.view addSubview:self.footView];
    
    
}

#pragma mark - --------------------返回上一界面----------------------
- (void)backView
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    
    //移除加载动画
    [self.waitView dismiss];
}


#pragma mark - ---------------------获取数据----------------------

- (void)receiveNetWorkingData
{
    [OrangeBaseNetWorking orangeGetRequestWithUrl:self.urlStr successData:^(NSDictionary *dic){
        
        [self.lookBook JSONLookBookDataModel:dic];
        
        [self scollViewImage];
        
        //关闭加载动画
        [self.waitView dismiss];
    }];
    
}


#pragma mark - -----------------设置滑动视图---------------

- (void)scollViewImage
{
    if (self.mainView.scrollView.subviews.count != 0) {
        for(int i = 0;i<self.mainView.scrollView.subviews.count;i++)
        {
            [[self.mainView.scrollView.subviews objectAtIndex:i] removeFromSuperview];
        }
    }

    if (self.lookBook.imageArr.count != 0) {
        
        self.mainView.scrollView.contentSize = CGSizeMake(self.mainView.frame.size.width * self.lookBook.imageArr.count, 0);
        
        for (int i = 0; i < self.lookBook.imageArr.count; i++) {

            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.scrollView.frame.size.width * i, 0,self.mainView.scrollView.frame.size.width , self.mainView.scrollView.frame.size.height)];
            [imageview sd_setImageWithURL:[NSURL URLWithString:self.lookBook.imageArr[i]]];
            [self.mainView.scrollView addSubview:imageview];
            
        }
    }
    
    // 设置分页效果
    self.mainView.scrollView.pagingEnabled = YES;
    //headView中进度条的最大值
    self.headView.slider.maximumValue = self.lookBook.imageArr.count;
    
}

#pragma mark - 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    int n = (self.mainView.scrollView.contentOffset.x +0.5 * self.mainView.scrollView.bounds.size.width)/self.mainView.scrollView.bounds.size.width+1;
    // 设置indexLabel
    self.headView.indexLabel.text = [NSString stringWithFormat:@"%d/%ld",n,self.lookBook.imageArr.count];
    // 设置进度
    self.headView.slider.value = n;
}

// 滑动条关联的方法

- (void)sliderMethod
{
    int sliderValue= (int)self.headView.slider.value;
    self.headView.indexLabel.text = [NSString stringWithFormat:@"%d/%ld",sliderValue,self.lookBook.imageArr.count];
    self.mainView.scrollView.contentOffset = CGPointMake(self.mainView.scrollView.bounds.size.width * (sliderValue -1), 0);
    
}


#pragma mark --------------------点击手势关联的方法--------------------
- (void)touchMethod
{

    static int i = 1;

    if (i%2 == 0) {
        self.headView.hidden = NO;
        self.footView.hidden = NO;
        i++;
    }
    else
    {
        self.headView.hidden = YES;
        self.footView.hidden = YES;
        self.footView.alpSlider.hidden = YES;
        i++;
    }
}




@end
