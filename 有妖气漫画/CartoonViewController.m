//
//  CartoonViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CartoonViewController.h"
#import "JingPingTableViewController.h"
#import "UpdateViewController.h"
#import "fl_ViewController.h"
#import "RankingListViewController.h"
#import "MenuScrollView.h"
#import "UIBarButtonItem+Extension.h"
#import "ViewController.h"
#import "OceanViewController.h"

@interface CartoonViewController ()<UIScrollViewDelegate>
///头部的滑动菜单
@property (nonatomic,strong) MenuScrollView *menuScrollView;

///四个子视图之一
@property (nonatomic,strong) UIViewController *firstVC;
@property (nonatomic,strong) UIViewController *secondVC;
@property (nonatomic,strong) UIViewController *thirdVC;
@property (nonatomic,strong) UIViewController *fourVC;

///当前子视图控制器
@property (nonatomic,strong) UIViewController *currentVC;
///父视图控制器下方的ScrollView视图
@property (nonatomic,strong) UIScrollView *contentScrollView;

///确定当前页
@property (nonatomic,assign) NSInteger currentPage;

///右边抽屉视图控制器
@property (nonatomic,strong) OceanViewController *leftVC;
///抽屉视图对应的返回蒙版
@property (nonatomic,strong) UIView *backView;


@end

@implementation CartoonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建容纳子视图控制器的视图的视图
    [self creatContentView];
    
    //创建顶部的滑动菜单
    [self creatTopMenu];
    
    //初始化子视图控制器
    [self setupChildVC];
    
    //设置导航栏
    [self setupNav];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeView:) name:@"changeView" object:nil];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置导航栏
- (void)setupNav
{
    //设置左耳目
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTagert:self action:@selector(GoToLeftView) image:@"nav_main_menu_n" highImage:@"nav_shelf_menu_n"];
    
    //设置右耳目
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"🔍" style:UIBarButtonItemStyleDone target:self action:@selector(GoToSearch)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - 右耳目关联方法(跳转到搜索页面)
- (void)GoToSearch
{
    ViewController *ViewVC = [[ViewController alloc] init];
    ViewVC.title = @"搜索";
    [self.navigationController pushViewController:ViewVC animated:YES];
}


#pragma mark - 左耳目关联方法(左侧抽屉视图切换)
- (void)GoToLeftView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.leftVC.view.frame;
        CGRect scrollRect = self.contentScrollView.frame;
        if (rect.origin.x == 0) {
            rect.origin.x = -200;
            scrollRect.origin.x = 0;
            [self.backView removeFromSuperview];
        }else
        {
            rect.origin.x = 0;
            scrollRect.origin.x = 200;
            [self creatBackView];
        }
        self.leftVC.view.frame = rect;
        self.contentScrollView.frame = scrollRect;
    }];
    
}


#pragma mark - 创建下方放ScrollView的方法
- (void)creatContentView
{
    //创建
    self.contentScrollView = [[UIScrollView alloc] init];
    //设置尺寸
    self.contentScrollView.frame = [UIScreen mainScreen].bounds;
    //设置滚动范围
    self.contentScrollView.contentSize = CGSizeMake(4*375, 0);
    //去除弹簧效果
    self.contentScrollView.bounces = NO;
    //设置分页
    self.contentScrollView.pagingEnabled = YES;
    //清除背景色
    self.contentScrollView.backgroundColor = [UIColor clearColor];
    //设置代理
    self.contentScrollView.delegate = self;
    
    //添加到主视图上
    [self.view addSubview:self.contentScrollView];
}



#pragma mark - 初始化各个子视图控制器
- (void)setupChildVC
{
    CGFloat viewW = 375;
    
    //加载四个子视图
    self.firstVC = [[JingPingTableViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 50, 375, 667 - 115)];
    [self addChildViewController:self.firstVC];
    
    self.secondVC = [[fl_ViewController alloc] init];
    [self.secondVC.view setFrame:CGRectMake(viewW, 50, 375, 617)];
    [self addChildViewController:self.secondVC];
    
    self.thirdVC = [[UpdateViewController alloc] init];
    [self.thirdVC.view setFrame:CGRectMake(viewW * 2, 50, 375, 617)];
    [self addChildViewController:self.thirdVC];
    
    self.fourVC = [[RankingListViewController alloc] init];
    [self.fourVC.view setFrame:CGRectMake(viewW * 3, 50, 375, 617)];
    [self addChildViewController:self.fourVC];
    
    self.leftVC = [[OceanViewController alloc] init];
    [self.leftVC.view setFrame:CGRectMake(-200,50,200, 667)];
    [self.leftVC PassBlock:^{
       //返回首页
        [self back];
    }];
    
    
    [self.contentScrollView addSubview:self.firstVC.view];
    [self.contentScrollView addSubview:self.secondVC.view];
    [self.contentScrollView addSubview:self.thirdVC.view];
    [self.contentScrollView addSubview:self.fourVC.view];
    //添加到最上面
    [self.view insertSubview:self.leftVC.view aboveSubview:self.contentScrollView];

}


#pragma mark - 创建返回蒙版的方法
- (void)creatBackView
{
    //创建抽屉视图返回的蒙版
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(200,50,175, 607)];
    self.backView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.backView aboveSubview:self.contentScrollView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.backView addGestureRecognizer:tap];
}


#pragma mark - 点击手势的方法
- (void)back
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.leftVC.view.frame;
        CGRect scrollRect = self.contentScrollView.frame;
            rect.origin.x = -200;
            scrollRect.origin.x = 0;
            [self.backView removeFromSuperview];
        self.leftVC.view.frame = rect;
        self.contentScrollView.frame = scrollRect;
    }];
}


#pragma mark - 通知方法
- (void)changeView:(NSNotification *)notifi
{
    UIButton *btn = (UIButton *)notifi.object;
    
    //设置选中按钮的属性
    [self changeMenuBtnState:btn.tag];
    
    CGFloat offsetx = self.view.frame.size.width * (btn.tag - 100);
    [self.contentScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];

    //让滑动菜单滚动到对应的位置
    [self scrollTo:btn.frame];
}



#pragma mark - 滑动菜单滚动的方法
- (void)scrollTo:(CGRect)rect
{
    CGFloat offsetX = rect.origin.x;
    CGPoint new = CGPointMake(offsetX - 40, 0);
    
    for (UIImageView *imageView in self.menuScrollView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect old = imageView.frame;
                old.origin.x = offsetX;
                imageView.frame = old;
            }];
        }
    }
    
    [self.menuScrollView setContentOffset:new animated:YES];

}



#pragma mark - 创建顶部的滑动菜单
- (void)creatTopMenu
{
    NSArray *array = [NSArray arrayWithObjects:@"精品",@"分类",@"更新",@"排行",nil];
    MenuScrollView *menu = [MenuScrollView MenuWith:array];
    menu.delegate = self;
    self.menuScrollView = menu;
    [self.view addSubview:menu];
}


#pragma mark - UIScrolleViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = scrollView.frame.size.width;
    if (scrollView == self.contentScrollView) {
        
        
        CGFloat offsetX = scrollView.contentOffset.x;
        
        //确定当前页
        self.currentPage = (offsetX + 0.5 * scrollW) / scrollW;
        
        //改变头部滑动菜单的状态
        [UIView animateWithDuration:0.3 animations:^{
            CGRect old = self.menuScrollView.MenuImage.frame;
            old.origin.x = self.currentPage * 120 + 40;
            self.menuScrollView.MenuImage.frame = old;
        }];
        
        //改变头部菜单按钮的状态
        NSInteger newtag = 100 + self.currentPage;
        [self changeMenuBtnState:newtag];
        
        if (self.currentPage == 0) {
            [self.menuScrollView setContentOffset:CGPointMake(self.currentPage * 60, 0) animated:YES];

        }else{
            [self.menuScrollView setContentOffset:CGPointMake(self.currentPage * 60 + 40, 0) animated:YES];
        }

#warning 刷新表格数据
        //刷新对应表格的数据
//        [self.viewsArray[self.currentPage] reloadData];
    }
}



#pragma mark - 根据对应的tag值改变对应按钮的状态
- (void)changeMenuBtnState:(NSInteger)tag
{
    for (UIButton *subBtn in self.menuScrollView.subviews) {
        if ([subBtn isKindOfClass:[UIButton class]]) {
            if (subBtn.tag == tag) {
                subBtn.selected = YES;
                subBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            }else{
                subBtn.selected = NO;
                subBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            }
        }
        
    }
}


@end
