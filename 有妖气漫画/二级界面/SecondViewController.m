//
//  SecondViewController.m
//  有妖气
//
//  Created by mac on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"
#import "SecondRankingListTableViewCell.h"
#import "SecondRankingListJsonMadel.h"
#import "RankingListViewController.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LookCartoonViewController.h"
#import "HeadRefreshView.h"
#import "FooterRefreshView.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* secondtableView;

@property (nonatomic,strong) LoadingView *waitView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化解析模型
    secondJsonModel = [[SecondRankingListJsonMadel alloc]init];
    
    self.secondtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 115)style:UITableViewStylePlain];
    
    self.secondtableView.dataSource = self;
    self.secondtableView.delegate = self;
    self.secondtableView.alpha = 0;
    self.secondtableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.secondtableView];
    
    [self sendUrlConnection:_urlStr];
    
    //设置加载动画
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.view];
    
    
    //创建下拉刷新
    HeadRefreshView *header = [HeadRefreshView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据..."];
            [self.secondtableView.mj_header endRefreshing];
        });
        
        
    }];
    self.secondtableView.mj_header = header;
    
    
    //创建上拉刷新界面
    self.secondtableView.mj_footer = [FooterRefreshView footerWithRefreshingBlock:^{
        //刷新数据
        [self sendUrlConnection:@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800139&page=1&argName=topic&argValue=8&size=20&from=10.1.8.1&"];
    }];
}



#pragma mark - ---------------构建网络请求---------------
- (void)sendUrlConnection:(NSString*)URLstr
{
    AFHTTPSessionManager* manage = [AFHTTPSessionManager manager];
    
    [manage GET:URLstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        
        [secondJsonModel jsonModelMethod:dic];
        [self.secondtableView reloadData];
        self.secondtableView.alpha = 1;
        [self.waitView dismiss];
        [self.secondtableView.mj_header endRefreshing];
        [self.secondtableView.mj_footer endRefreshing];
        
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

/**
 *  tableview的行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (secondJsonModel.allJsonDataMutArray.count == 0) {
        return 1;
    }else
        return secondJsonModel.allJsonDataMutArray.count;
    
}

/**
 *  tableviewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideCell = @"secondideCell";
    
    secondRankingListTableViewCell = [tableView dequeueReusableCellWithIdentifier:ideCell];
    if (secondRankingListTableViewCell == nil) {
        secondRankingListTableViewCell = [[SecondRankingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideCell];
    }
    
    
    if (secondJsonModel.allJsonDataMutArray.count != 0) {
        
        NSMutableDictionary *dic = [secondJsonModel.allJsonDataMutArray objectAtIndex:indexPath.row];
        
        
        [secondRankingListTableViewCell.imageViewSecond sd_setImageWithURL:[NSURL URLWithString:dic[@"cover"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
        NSMutableString* styleStr  = [[NSMutableString alloc] init];
        NSArray *StrArray = dic[@"tags"];
        for (int i = 0; i < StrArray.count; i++ ) {
            NSString *str = StrArray[i];
            [styleStr appendString:str];
        }
        
        secondRankingListTableViewCell.name.text = dic[@"name"];
        secondRankingListTableViewCell.nickNameLable.text = dic[@"nickname"];
        secondRankingListTableViewCell.clickTotalLable.text = dic[@"click_total"];
        secondRankingListTableViewCell.styleLable.text = styleStr;
        secondRankingListTableViewCell.chapter_numLable.text = dic[@"extraValue"];
        
        
        secondRankingListTableViewCell.dujiaImageView.alpha  = 0;
        NSInteger dujia = [dic[@"is_dujia"] integerValue];
        if (dujia == 1) {
            secondRankingListTableViewCell.dujiaImageView.alpha  = 1;
        }
        /**
         *  自动求取控件宽度
         */
        [secondRankingListTableViewCell.nickNameLable sizeToFit];
        secondRankingListTableViewCell.frame = CGRectMake(94, 55, secondRankingListTableViewCell.frame.size.width, secondRankingListTableViewCell.frame.size.height);
        
        secondRankingListTableViewCell.image2.frame = CGRectMake(125+secondRankingListTableViewCell.nickNameLable.frame.size.width, 52, 15, 15);
        
        CGFloat width = secondRankingListTableViewCell.image2.frame.size.width + 124+secondRankingListTableViewCell.nickNameLable.frame.size.width + 10;
        [secondRankingListTableViewCell.clickTotalLable sizeToFit];
        secondRankingListTableViewCell.clickTotalLable.frame = CGRectMake(width-5, 54, secondRankingListTableViewCell.clickTotalLable.frame.size.width, secondRankingListTableViewCell.clickTotalLable.frame.size.height);
        
        CGFloat width2 = secondRankingListTableViewCell.clickTotalLable.frame.size.width + width;
        secondRankingListTableViewCell.image3.frame = CGRectMake(width2, 54, 14, 14);
        
        [secondRankingListTableViewCell.styleLable sizeToFit];
        CGFloat width3 = width2+20+20;
        secondRankingListTableViewCell.styleLable.frame = CGRectMake(width3-20, 54,secondRankingListTableViewCell.styleLable.frame.size.width, secondRankingListTableViewCell.styleLable.frame.size.height);
        
    }
    
    return secondRankingListTableViewCell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookCartoonViewController *cartoonVC = [[LookCartoonViewController alloc] init];
    cartoonVC.urlString = @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453545503&comicid=31529&";
    [self.navigationController pushViewController:cartoonVC animated:YES];
}

@end
