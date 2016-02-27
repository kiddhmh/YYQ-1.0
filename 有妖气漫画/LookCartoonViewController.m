//
//  LookCartoonViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LookCartoonViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "comicModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "chapter_listModel.h"
#import "LoadingView.h"
#import "LookBookViewController.h"

@interface LookCartoonViewController ()<UITableViewDataSource,UITableViewDelegate>
///漫画图片
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
///漫画名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///漫画作者
@property (weak, nonatomic) IBOutlet UILabel *author_nameLabel;
///漫画类型
@property (weak, nonatomic) IBOutlet UILabel *theme_idsLabel;
///点击量
@property (weak, nonatomic) IBOutlet UILabel *click_totalLabel;
///简介
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
///目录列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

///加载动画的视图
@property (nonatomic,strong) LoadingView *waitView;

///上部分简介模型
@property (nonatomic,strong) comicModel *comicML;

///下部分tableView模型数组
@property (nonatomic,strong) NSMutableArray *chapter_listModelArray;

///TableView的尾部视图
@property (nonatomic,strong) UIImageView  *footImageView;

@end

@implementation LookCartoonViewController

- (NSMutableArray *)chapter_listModelArray
{
    if (_chapter_listModelArray == nil) {
        _chapter_listModelArray = [[NSMutableArray alloc] init];
    }
    return _chapter_listModelArray;
}


- (comicModel *)comicML
{
    if (_comicML == nil) {
        _comicML = [[comicModel alloc] init];
    }
    return _comicML;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //发送网络请求
    [self setupNetWorking:self.urlString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.waitView = [[LoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.waitView showLoadingTo:self.view];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //创建TableView的尾部视图
    self.footImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.tableView.frame.size.width, 50)];
    self.footImageView.image = [UIImage imageNamed:@"comicinfo_cell_continue"];
    self.tableView.tableFooterView = self.footImageView;
    
    //设置导航栏
    [self setupNav];
}

#pragma mark - 设置导航栏
- (void)setupNav
{
    self.title = @"漫画介绍";
}


#pragma mark - 发送网络请求
- (void)setupNetWorking:(NSString *)urlString
{
    //发送网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:self.urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取上部分模型数据
        [self setupFirstModel:responseObject];
        
        //设置上部分的UI的数据
        [self setupUIdata];
        
        //设置下部分UITableView的数据模型
        [self setupTableViewData:responseObject];
        
        //停止加载动画
        [self.waitView dismiss];
        
        //刷新表格数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay:1.5];
    }];
}

#pragma mark - 设置下部分UITableView的模型
- (void)setupTableViewData:(id)obj
{
    NSDictionary *dataDic = obj[@"data"];
    NSDictionary *returnDataDic = dataDic[@"returnData"];
    NSArray *array = returnDataDic[@"chapter_list"];
    
    self.chapter_listModelArray = [chapter_listModel mj_objectArrayWithKeyValuesArray:array];
}


#pragma mark - 获取上部分模型数据
- (void)setupFirstModel:(id)obj
{
    NSDictionary *dataDic = obj[@"data"];
    NSDictionary *returnDataDic = dataDic[@"returnData"];
    self.comicML = [comicModel mj_objectWithKeyValues:returnDataDic[@"comic"]];
}


#pragma mark - 设置上部分UI的数据
- (void)setupUIdata
{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.comicML.cover] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.nameLabel.text = self.comicML.name;
    
    self.author_nameLabel.text = [NSString stringWithFormat:@"作者是:%@",self.comicML.author_name];
    
    self.theme_idsLabel.text = self.comicML.theme_ids;
    
    self.click_totalLabel.text = [NSString stringWithFormat:@"点击量:%@",self.comicML.click_total];
    
    self.descriptionLabel.text = self.comicML.des;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chapter_listModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.chapter_listModelArray.count != 0) {
        chapter_listModel *model = self.chapter_listModelArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"   %@  (%ldP)",model.name,model.image_total];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
//选中某行时跳到对应的漫画页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LookBookViewController *bookVC = [[LookBookViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453776163&imgtype=1&chapter_id=266221&";
            break;
        case 1:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453788786&imgtype=1&chapter_id=405862&";
            break;
        case 2:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453796535&imgtype=1&chapter_id=459395&";
            break;
        case 3:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453793447&imgtype=1&chapter_id=277022&";
            break;
            
        case 4:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453777880&imgtype=1&chapter_id=356123&";
            break;
            
        case 5:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453794056&imgtype=1&chapter_id=298064&";
            break;
            
        default:
            bookVC.urlStr = @"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453792982&imgtype=1&chapter_id=458940&";
            break;
    }
    [self presentViewController:bookVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
