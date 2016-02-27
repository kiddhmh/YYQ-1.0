//
//  NewBootViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "NewBootViewController.h"
#import "AppDelegate.h"
#import "HMHNavViewController.h"
#import "CartoonViewController.h"

@interface NewBootViewController ()

@end

@implementation NewBootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    CGFloat imageY = 0;
    for (int i = 0; i < 4; i++ ) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"boot_%d",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * imageW, imageY, imageW, imageH)];
        imageView.image = image;
        [scrollView addSubview:imageView];
        
        if (i == 3) {
            imageView.userInteractionEnabled = YES;
            [self creatLastImage:imageView];
        }
        
    }
    scrollView.contentSize = CGSizeMake(4 * imageW, 0);
    [self.view addSubview:scrollView];    
}


#pragma mark - 创建进入首页的按钮
- (void)creatLastImage:(UIImageView *)imageView
{
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake( 104 , 562 , 116 ,64);
    newBtn.backgroundColor = [UIColor clearColor];
    
    [newBtn addTarget:self action:@selector(GoToShouYe) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:newBtn];
}



/**
 *  进入漫画首页
 *
 */
- (void)GoToShouYe
{
    /*切换控制器的手段
     1.push
     2.modal
     3.切换控制器window的rootViewcontroller(这种方法不可逆，用这个方法)
     */
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    CartoonViewController *carVC = [[CartoonViewController alloc] init];
    
    HMHNavViewController *nav = [[HMHNavViewController alloc] initWithRootViewController:carVC];
    carVC.title = @"有妖气";
    
    [carVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerViewDetail"] forBarMetrics:UIBarMetricsDefault];
    
    delegate.window.rootViewController = nav;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
