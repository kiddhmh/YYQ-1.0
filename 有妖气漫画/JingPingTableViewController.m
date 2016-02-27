//
//  JingPingTableViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "JingPingTableViewController.h"
#import "JingPingHeadView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "BigModel.h"
#import "SmallModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "SectionHeadView.h"
#import "HMHTableViewCell.h"
#import "JingPingFootView.h"
#import "LookCartoonViewController.h"
#import "LoadingView.h"
#import "HeadRefreshView.h"

@interface JingPingTableViewController ()<UIScrollViewDelegate>
//头部滚动视图的图片数据
@property (nonatomic,strong) NSMutableArray *headImageArray;
//头部视图
@property (nonatomic,strong) JingPingHeadView *headView;
///漫画数据的数组
@property (nonatomic,strong) NSMutableArray *CartoonArray;
///漫画尾部视图的图片数组
@property (nonatomic,strong) NSMutableArray *footImageArray;
///尾部视图
@property (nonatomic,strong) JingPingFootView *footView;
///加载动画视图
@property (nonatomic,strong) LoadingView *waitView;

@end

@implementation JingPingTableViewController

- (NSMutableArray *)footImageArray
{
    if (_footImageArray == nil) {
        _footImageArray = [[NSMutableArray alloc] init];
    }
    return _footImageArray;
}

- (NSMutableArray *)CartoonArray
{
    if (_CartoonArray == nil) {
        _CartoonArray = [[NSMutableArray alloc] init];
    }
    return _CartoonArray;
}

- (NSMutableArray *)headImageArray
{
    if (_headImageArray == nil) {
        _headImageArray = [[NSMutableArray alloc] init];
    }
    return _headImageArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //发送网络请求
    [self creatURL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置头部视图
    self.headView = [[JingPingHeadView alloc] initWithFrame:CGRectMake(0,0,375, 160)];
    self.tableView.tableHeaderView = self.headView;
    
    //设置尾部视图
    self.footView = [[JingPingFootView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    self.tableView.tableFooterView = self.footView;
    
    //设置加载等待动画
    LoadingView *load = [[LoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [load showLoadViewTo:[UIApplication sharedApplication].keyWindow];
    self.waitView = load;
    
    //创建并设置下拉刷新控件
    [self setupRefresh];
}


#pragma mark - 创建并设置上拉刷新控件
- (void)setupRefresh
{
    //创建下拉刷新
    HeadRefreshView *header = [HeadRefreshView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据..."];
            [self.tableView.mj_header endRefreshing];
        });
        
        
    }];
    self.tableView.mj_header = header;
}


#pragma mark - 发送网络请求
- (void)creatURL
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://app.u17.com/v3/app/ios/phone/recommend/itemlist?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453445152&" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获得顶部视图的数据
        [self setupheadView:responseObject];
        
        //设置顶部视图数据
        if (self.headView.imageArray.count == 0) {
        self.headView.imageArray = self.headImageArray;
        }

        //将获取的漫画数据转换成对应的模型
        [self setupCartoonArray:responseObject];
        
        //获取尾部视图的数据
        [self setupFootView:responseObject];
        
        //设置尾部视图的数据
        self.footView.imageArray = self.footImageArray;
        
        //取消加载动画
        [self.waitView dismiss];
        
        //取消下拉刷新控件
        [self.tableView.mj_header endRefreshing];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay:1.5];
        
        //取消下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        //取消蒙版动画
        [self.waitView dismiss];
        
        
        
    }];
    
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 10;
}

#pragma mark - 获取尾部视图的数据
- (void)setupFootView:(id)obj
{
    NSDictionary *data = obj[@"data"];
    NSDictionary *returnData = data[@"returnData"];
    NSArray *dataList = [returnData valueForKey:@"dataList"];
    NSDictionary *footDic = [dataList lastObject];
    NSArray *footArr = footDic[@"bannerItems"];
    
    for (NSDictionary *footD in footArr) {
        [self.footImageArray addObject:footD[@"smallImageUrl"]];
    }
}


#pragma  mark - 将漫画数据转换成模型
- (void)setupCartoonArray:(id)obj
{
    NSDictionary *data = obj[@"data"];
    NSDictionary *returnData = data[@"returnData"];
    NSArray *dataList = [returnData valueForKey:@"dataList"];
    NSMutableArray *CartoonDic = [NSMutableArray array];
    for (int i = 1; i < dataList.count - 1; i++ ) {
        [CartoonDic addObject:dataList[i]];
    }
    
    self.CartoonArray = [BigModel mj_objectArrayWithKeyValuesArray:CartoonDic];
}


#pragma mark - 获得顶部视图的数据
- (void)setupheadView:(id)obj
{
    
    //获得顶部滚动视图的数据
    NSDictionary *data = obj[@"data"];
    NSDictionary *returnData = data[@"returnData"];
    NSArray *dataList = [returnData valueForKey:@"dataList"];
    NSDictionary *itemView = [dataList objectAtIndex:0];
    NSArray *galleryItems = [itemView valueForKey:@"galleryItems"];
    
    if (self.headImageArray.count == 0) {
        for (NSDictionary *imageDic in galleryItems) {
            NSString *imageURL = [imageDic valueForKey:@"smallImageUrl"];
            NSURL *url = [NSURL URLWithString:imageURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data) {
            [self.headImageArray addObject:data];
            }
        }
    }else
    {
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.CartoonArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.CartoonArray.count != 0) {
        BigModel *model = self.CartoonArray[section];
        return model.comicListItems.count;
    }else{
        return 10;
    }
}


///返回怎么样的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BigModel *bigML = self.CartoonArray[indexPath.section];
    SmallModel *model = bigML.comicListItems[indexPath.row];

    //创建自定义cell
    HMHTableViewCell *cell = [HMHTableViewCell cellWith:tableView];
    
    if (bigML.comicListItems.count != 0) {
        cell.smallML = model;
    }

    return cell;
}

///返回每一组的头部试图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BigModel *model = self.CartoonArray[section];
    SectionHeadView *headView = [[SectionHeadView alloc] initWithFrame:CGRectMake(0,section * 35 , 375, 35)];
    headView.imageURL = model.titleIconUrl;
    headView.title = model.titleWithIcon;
    
    return headView;
}

//头部试图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

//返回尾部视图


#pragma mark - UITableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ///进入漫画详情页面
    LookCartoonViewController *lookVC = [[LookCartoonViewController alloc] init];
    switch (indexPath.section) {
        case 0:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453794292&comicid=107035&";
            break;
        case 1:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453789246&comicid=81972&";
            break;
        case 2:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453796504&comicid=115616&";
            break;
        case 3:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453793377&comicid=71064&";
            break;
        case 4:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453795217&comicid=96150&";
            break;
        case 5:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453788628&comicid=81162&";
            break;
        case 6:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453777841&comicid=90194&";
            break;
        case 7:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453793997&comicid=76305&";
            break;
        case 8:
            lookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453791380&comicid=68795&";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:lookVC animated:YES];
}

@end
