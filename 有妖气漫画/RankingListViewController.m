//
//  ClassifyViewController.m
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "RankingListViewController.h"
#import "RankingListJsonModel.h"
#import "RankingListTableViewCell.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "SecondViewController.h"
#import "SecondRankingListJsonMadel.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
@interface RankingListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;

@property (nonatomic,strong) LoadingView *waitView;

@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    /**
     *      tableview 初始化
     */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 80)style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.alpha = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    //动画
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.view];
    
    /**
     模型初始化
     */
    jsonModel = [[RankingListJsonModel alloc] init];
    
    
    /**
     *  创建网络请求
     *
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:@"http://app.u17.com/v3/app/ios/phone/rank/list?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453448735&rankVersion=2&from=10.1.3.4&" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        
        [jsonModel jsonModelMethod:dic];
        //NSLog(@"%@",dic);
        [self.tableView reloadData];
        self.tableView.alpha = 1;
        
        [self.waitView dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.waitView dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
    
}



#pragma mark - ---------------数据源方法---------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (jsonModel.allJsonDataMutArray.count == 0) {
        return 1;
    }else
        return jsonModel.allJsonDataMutArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideCell = @"ideCell";
    rankingListCell = [tableView dequeueReusableCellWithIdentifier:ideCell];
    if (rankingListCell == nil) {
        rankingListCell = [[RankingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideCell];
    }
    
    if (jsonModel.allJsonDataMutArray.count != 0) {
        NSMutableDictionary *dic = [jsonModel.allJsonDataMutArray objectAtIndex:indexPath.row];
        
        [rankingListCell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"cover"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        rankingListCell.titleLabel.text = dic[@"rankingName"];
        rankingListCell.rankingDescription1Label.text = dic[@"rankingDescription1"];
        rankingListCell.rankingDescription2Label.text = dic[@"rankingDescription2"];
        
    }
    
    
    return rankingListCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _number = indexPath.row;
    
    
    SecondViewController* secondVC = [[SecondViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453445622&page=1&argName=sort&argValue=23&size=20&from=10.1.3.4&";
            break;
        case 1:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453445888&page=1&argName=sort&argValue=9&size=20&from=10.1.3.4&";
            break;
        case 2:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446109&page=1&argName=sort&argValue=20&size=20&from=10.1.3.4&";
            break;
        case 3:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446222&page=1&argName=sort&argValue=15&size=20&from=10.1.3.4&";
            break;
        case 4:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446298&page=1&argName=sort&argValue=17&size=20&from=10.1.3.4&";
            break;
        case 5:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446383&page=1&argName=sort&argValue=18&size=20&from=10.1.3.4&";
            break;
        case 6:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446470&page=1&argName=sort&argValue=19&size=20&from=10.1.3.4&";
            break;
        case 7:
            secondVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/list/index?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453446514&page=1&argName=sort&argValue=2&size=20&from=10.1.3.4&";
            break;
            
        default:
            break;
    }
    
    NSMutableDictionary *dic = [jsonModel.allJsonDataMutArray objectAtIndex:indexPath.row];
    secondVC.title = dic[@"rankingName"];
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:secondVC animated:YES];
}

@end
