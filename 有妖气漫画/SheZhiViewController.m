//
//  SheZhiViewController.m
//  Ocean1
//
//  Created by ma c on 16/1/26.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import "SheZhiViewController.h"
#import "SugestionViewController.h"
#import "AboutViewController.h"
#import "SVProgressHUD.h"

@interface SheZhiViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) NSArray *footerTitle;
/**
 *  缓存Label
 */
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    NSArray *arr1 = @[@"清除缓存"];
    NSArray *arr2 = @[@"使用2G/3G/4G网络"];
    NSArray *arr3 = @[@"意见反馈",@"关于腾讯动漫"];
    self.datasource = @[arr1,arr2,arr3];
    
    self.footerTitle = @[@"不影响已下载的动漫",@"允许在2G/3G/4G网络时下载动漫",@""];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.datasource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[self.datasource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    /**设置cell尾部*/
    if (indexPath.section == 0)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(300, 8, 65, 26)];
        label.text = [NSString stringWithFormat:@"%fMB",arc4random() % 40 + 0.3];
        label.textColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        self.titleLabel = label;
    }
    else if(indexPath.section == 1)
    {
        UISwitch *netSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(310, 8, 65, 26)];
        [netSwitch addTarget:self action:@selector(netSwitchEvent:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:netSwitch];
    }
    else if(indexPath.section == 2)
    {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}
///设置题尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 375, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = [self.footerTitle objectAtIndex:section];
    [view addSubview:label];
    
    return view;
}
///开关方法
- (void)netSwitchEvent:(UISwitch *)Switch
{
    if ([Switch isOn]) {
        [SVProgressHUD showSuccessWithStatus:@"已开启4G"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"已关闭4G"];
    }
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        [SVProgressHUD showWithStatus:@"正在清理"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"清理完毕"];
            self.titleLabel.text = @"";
        });
    }
    
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        SugestionViewController *sugestionVC = [[SugestionViewController alloc] init];
        sugestionVC.title = @"意见反馈";
        [self.navigationController pushViewController:sugestionVC animated:YES];
        
    }
    else if(indexPath.section == 2 && indexPath.row == 1){
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        aboutVC.title = @"关于腾讯动漫";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
