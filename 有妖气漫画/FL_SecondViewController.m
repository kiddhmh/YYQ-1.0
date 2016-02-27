//
//  FL_SecondViewController.m
//  有妖气_分类
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "FL_SecondViewController.h"
#import "FLTableViewCell.h"
#import "OrangeBaseNetWorking.h"
#import "FL_SecondModel.h"
#import "LoadingView.h"
#import "HeadRefreshView.h"
#import "LookCartoonViewController.h"
#import "FooterRefreshView.h"
#import "SVProgressHUD.h"
@interface FL_SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *secondArray;
///等待动画
@property (nonatomic,strong) LoadingView *waitView;
@end
static NSString *cellID = @"cellID";
@implementation FL_SecondViewController

- (NSMutableArray *)secondArray
{
    if (_secondArray == nil) {
        _secondArray = [[NSMutableArray alloc] init];
    }
    return _secondArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.fl_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 597) style:UITableViewStylePlain];
     ///设置代理
    self.fl_tableView.delegate = self;
    self.fl_tableView.dataSource = self;
    
    [self.view addSubview:self.fl_tableView];
    
    
    [self createURlwork:@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453626227&page=1&argName=theme&argValue=1&size=20&from=10.1.8.1&"];
    
    //创建等待动画
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    [self.waitView showLoadingTo:self.view];
    
    
    //创建下拉刷新
    HeadRefreshView *header = [HeadRefreshView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据..."];
            [self.fl_tableView.mj_header endRefreshing];
        });
        
        
    }];
    self.fl_tableView.mj_header = header;
    
    
    //创建上拉刷新界面
    self.fl_tableView.mj_footer = [FooterRefreshView footerWithRefreshingBlock:^{
        //刷新数据
        [self createURlwork:@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800047&page=1&argName=special&argValue=35&size=20&from=10.1.8.1&"];
    }];
    
}
///网络请求
- (void)createURlwork:(NSString *)url
{
    
    [OrangeBaseNetWorking orangeGetRequestWithUrl:self.URLStr successData:^(NSDictionary *dic) {
      
        NSDictionary *datadic = dic[@"data"];
        NSArray *arr = datadic[@"returnData"];
        ///快速遍历
        for (NSDictionary *dic1 in arr) {
            FL_SecondModel *secondModel = [[FL_SecondModel alloc] initWith:dic1];
            [self.secondArray addObject:secondModel];
        }
        [self.fl_tableView reloadData];
        
        //关闭动画
        [self.waitView dismiss];
        
        //关闭刷新
        [self.fl_tableView.mj_header endRefreshing];
        
        //隐藏上啦刷新控件
        [self.fl_tableView.mj_footer endRefreshing];
    }];
    
}


//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.secondArray != 0) {
        return  self.secondArray.count;
    }else
    {
        return 10;
    }

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FLTableViewCell" owner:nil options:nil]lastObject];
    }
    if (self.secondArray.count != 0) {
        FL_SecondModel *model = self.secondArray[indexPath.row];
        cell.fl_SecondModel = model;
    }
    return cell;
}


//选中某行cell会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.fl_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //切换看漫画的页面
    LookCartoonViewController *cartoonVC = [[LookCartoonViewController alloc] init];
    cartoonVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453545503&comicid=31529&";
    
    [self.navigationController pushViewController:cartoonVC animated:YES];
}



#pragma mark - 组高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}



@end
