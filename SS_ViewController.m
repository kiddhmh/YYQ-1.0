//
//  SS_ViewController.m
//  有妖气漫画--搜索界面二
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "SS_ViewController.h"
#import "SearchBar_textField.h"

@interface SS_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    BOOL LSJL;
}
@property (strong, nonatomic) UISegmentedControl *segment;

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *LSJLArr;

@property (strong, nonatomic) NSArray *XGTJArr;

@property (strong, nonatomic) UIView *otherView;

@property (nonatomic,strong) SearchBar_textField *searchBar;

@end

@implementation SS_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.otherView.frame;
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"two_lajitong"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clearMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.otherView addSubview:btn];

    
    LSJL = YES;
    NSArray *Arr =@[@"长歌行",@"镇魂街",@"琉璃夜",@"瑞脑",@"剑三",@"宝鉴"];
    
    self.LSJLArr = [[NSMutableArray alloc] initWithArray:Arr];
    
    self.XGTJArr =@[@"火影",@"盗墓笔记",@"完美世界",@"海贼王"];

    
    [self createTableView];
    [self createSegment];


    [self creatSearchBar];
    

}

#pragma mark - 设置头部的搜索框
- (void)creatSearchBar
{
    SearchBar_textField *search = [SearchBar_textField searchBar];
    search.frame = CGRectMake(0, 0, 340, 35);
    self.navigationItem.titleView = search;
    self.searchBar = search;
    self.searchBar.delegate = self;
}


//退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchBar resignFirstResponder];
    return YES;
}


- (void)clearMethod
{
    self.LSJLArr = [[NSMutableArray alloc] initWithCapacity:10];
    [self.myTableView reloadData];
}

/// 创建分段控制器
- (void)createSegment
{
    NSArray *arr = @[@"历史记录",@"相关推荐"];

    self.segment = [[UISegmentedControl alloc] initWithItems:arr];
    self.segment.frame = CGRectMake(80, 21, self.view.bounds.size.width - 80*2, 29);
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventValueChanged];

    
    [self.view addSubview:self.segment];
    
}
/// 创建tableview
- (void)createTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 400) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView = [[UIView alloc] init];



    [self.view addSubview:self.myTableView];

    
}


/// 分段控制器相关的事件
- (void)clickMethod:(id)sender
{
    UISegmentedControl *temp = (UISegmentedControl*)sender;
    switch (temp.selectedSegmentIndex) {
        case 0:
            [self indexOneMethod];
            break;
        case 1:
            [self indexTwoMethod];
            break;
        default:
            break;
    }
}

- (void)indexOneMethod
{

    LSJL = YES;
   

    [self.myTableView reloadData];
}
- (void)indexTwoMethod
{
    LSJL = NO;
    [self.myTableView reloadData];
}


#pragma mark - tableView的代理和协议方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(LSJL == YES)
    {
        return self.LSJLArr.count;

    }
    return self.XGTJArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (LSJL == YES) {
        
        self.myTableView.tableFooterView = self.otherView;
        self.myTableView.tableFooterView.hidden = NO;
        cell.textLabel.text = [self.LSJLArr objectAtIndex:indexPath.row];
        

    }else
    {
        self.myTableView.tableFooterView.hidden = YES;
        cell.textLabel.text = [self.XGTJArr objectAtIndex:indexPath.row];
    }
    

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}





@end
