//
//  UpdateViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "UpdateViewController.h"
#import "FirstModel.h"
#import "FirstTableViewCell.h"
#import "OrangeBaseNetWorking.h"
#import "LookCartoonViewController.h"
#import "HeadRefreshView.h"
#import "FooterRefreshView.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface UpdateViewController ()


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation UpdateViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70)style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //表格代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    //设置开始加载时隐藏
    self.tableView.alpha = 0;
    
    [self.view addSubview:self.tableView];

    
    //请求网络
    [self createUrlNetWorking:@"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453445311&page=1&argName=sort&argValue=0&size=20&from=10.1.3.4&"];
    
    
    //创建下拉刷新
    HeadRefreshView *header = [HeadRefreshView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据..."];
            [self.tableView.mj_header endRefreshing];
        });
        
        
    }];
    self.tableView.mj_header = header;
    
    
    //创建上拉刷新界面
    self.tableView.mj_footer = [FooterRefreshView footerWithRefreshingBlock:^{
        //刷新数据
        [self createUrlNetWorking:@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800047&page=1&argName=special&argValue=35&size=20&from=10.1.8.1&"];
    }];

}


#pragma mark - ---------------网络部分---------------
- (void)createUrlNetWorking:(NSString *)urlStr
{
    [OrangeBaseNetWorking orangeGetRequestWithUrl:urlStr
            successData:^(NSDictionary *dic) {
            
                NSDictionary *dataDic = dic[@"data"];
                NSArray *returnDic = dataDic[@"returnData"];
                
                for (NSDictionary *dic in returnDic) {
                    FirstModel *model = [[FirstModel alloc] initWithDic:dic];
                    [self.dataArray addObject:model];
                }
                //NSLog(@"%@",dic);
                
                [self.tableView reloadData];
                
                //关闭刷新
                [self.tableView.mj_header endRefreshing];
                
                //隐藏上啦刷新控件
                [self.tableView.mj_footer endRefreshing];
                
                //加载成功后显示
            self.tableView.alpha = 1;
        
     }];
    
    
}


#pragma mark - --------------UIView部分-------------



#pragma mark - ---------------代理部分---------------
//设置表格组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }
    else
        return 1;
}

//设置表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置重用标识
    static NSString *identCell = @"identCell";
    //nib加载
    
    
    //TableViewCell放入重用队列中
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identCell];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstTableViewCell" owner:nil options:nil]lastObject];
    }
    
    if (self.dataArray.count != 0) {
        
        FirstModel *model = self.dataArray[indexPath.row];
        
        [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
        cell.nameLabel.text = model.name;
        cell.nicknameLabel.text = model.nickname;
        cell.extraValueLabel.text = model.extraValue;
        cell.last_update_chapter_nameLabel.text = model.last_update_chapter_name;
        cell.tagsLabel.text = model.tags;
        
        //NSInteger dujianum = [model.is_dujia integerValue];
        
        if ([model.is_dujia integerValue] == 1)
        {
            cell.is_dujiaimageView.alpha = 1;
        }
        else
        {
            cell.is_dujiaimageView.alpha = 0;
        }
    }
    
    
    return cell;
    
}

//设置表格行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

//表格点击事件，进入第二个界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookCartoonViewController* UplookVC = [[LookCartoonViewController alloc] init];
    
    UINavigationController *nav =(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    switch (indexPath.row) {
        case 0:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453794292&comicid=107035&";
            break;
        case 1:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453882091&comicid=82988&";
            break;
        case 2:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453881631&comicid=99105&";
            break;
        case 3:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453874979&comicid=114066&";
            break;
        case 4:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453882041&comicid=115448&";
            break;
        case 5:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453881848&comicid=109766&";
            break;
        case 6:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453881531&comicid=108994&";
            break;
        case 7:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453882383&comicid=76305&";
            break;
        default:
            UplookVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.9&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453882516&comicid=112067&";
            break;
    }
    

    
    FirstModel *model = self.dataArray[indexPath.row];
    
    UplookVC.title = model.name;
    
    [nav pushViewController:UplookVC animated:YES];
}



@end
