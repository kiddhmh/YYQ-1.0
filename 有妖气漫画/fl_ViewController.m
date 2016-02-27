//
//  fl_ViewController.m
//  有妖气_分类
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "fl_ViewController.h"
#import "FLCollectionViewCell.h"
#import "fl_model.h"
#import "OrangeBaseNetWorking.h"
#import "FL_SecondViewController.h"
@interface fl_ViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *modleArray;

///URL大礼包
@property (nonatomic,strong) NSArray *URLArray;

@end
static NSString *cellId = @"cellId";
@implementation fl_ViewController

- (NSMutableArray *)modleArray
{
    if (_modleArray == nil) {
        _modleArray = [[NSMutableArray alloc] init];
    }
    return _modleArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建布局，横向还是纵向
    UICollectionViewFlowLayout *fl_layout = [[UICollectionViewFlowLayout alloc]init];
    [fl_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置代理
    _fl_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, 375, 667 - 115) collectionViewLayout:fl_layout];
    _fl_collectionView.delegate = self;
    _fl_collectionView.dataSource = self;
    
    //注册单元格
    
    [_fl_collectionView registerNib:[UINib nibWithNibName:@"FLCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    //加载视图
    _fl_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_fl_collectionView];

    //构造解析模型
    _flmodel = [[fl_model alloc] init];
    
    
    //请求网络
    [self createURLWorking];
    
    
    ///网络链接大礼包
    ///搞笑，魔幻，生活
    NSArray *arr1 = @[@"http://app.u17.com/v3/app/ios/phone/sort/list?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453447061&sortVersion=2&from=10.1.3.4&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798577&page=1&argName=theme&argValue=2&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798640&page=1&argName=theme&argValue=3&size=20&from=10.1.8.1&"];
    ///恋爱，动作，科幻
    NSArray *arr2 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798691&page=1&argName=theme&argValue=4&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798750&page=1&argName=theme&argValue=5&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798775&page=1&argName=theme&argValue=6&size=20&from=10.1.8.1&"];
    ///战争，体育，推理
    NSArray *arr3 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798936&page=1&argName=theme&argValue=7&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453798981&page=1&argName=theme&argValue=8&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799032&page=1&argName=theme&argValue=9&size=20&from=10.1.8.1&"];
    ///恐怖，同人，少年
    NSArray *arr4 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799063&page=1&argName=theme&argValue=11&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799127&page=1&argName=theme&argValue=12&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799155&page=1&argName=cate&argValue=1&size=20&from=10.1.8.1&"];
    ///少女，四格，耽美
    NSArray *arr5 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799210&page=1&argName=cate&argValue=2&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799237&page=1&argName=cate&argValue=4&size=20&from=10.1.8.1",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799271&page=1&argName=cate&argValue=3&size=20&from=10.1.8.1&"];
    ///完结，周更，淘漫画
    NSArray *arr6 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799335&page=1&argName=serial&argValue=1&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799495&page=1&argName=topic&argValue=10&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799525&page=1&argName=topic&argValue=1&size=20&from=10.1.8.1&"];
    
    ///劲漫画，漫友文化，神界漫画
    NSArray *arr7 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799594&page=1&argName=topic&argValue=3&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799640&page=1&argName=topic&argValue=4&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799704&page=1&argName=topic&argValue=2&size=20&from=10.1.8.1&"];
    ///最漫画，猫控，彩漫
    NSArray *arr8 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453799739&page=1&argName=topic&argValue=5&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800047&page=1&argName=special&argValue=35&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800093&page=1&argName=topic&argValue=7&size=20&from=10.1.8.1&"];
    ///S级作品，A级作品，热门新作
    NSArray *arr9 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800139&page=1&argName=topic&argValue=8&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800184&page=1&argName=topic&argValue=9&size=20&from=10.1.8.1&",
                      @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800221&page=1&argName=sort&argValue=2&size=20&from=10.1.8.1&"];
    ///妖狐，校园，火影
    NSArray *arr10 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800259&page=1&argName=special&argValue=32&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800297&page=1&argName=special&argValue=33&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453811110&page=1&argName=special&argValue=38&size=20&from=10.1.8.1&"];
    ///剑三，星际，女王
    NSArray *arr11 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800399&page=1&argName=special&argValue=34&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800461&page=1&argName=special&argValue=40&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800514&page=1&argName=special&argValue=43&size=20&from=10.1.8.1&"];
    ///小说改编，穿越，古风
    NSArray *arr12 = @[@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800550&page=1&argName=special&argValue=44&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800577&page=1&argName=special&argValue=45&size=20&from=10.1.8.1&",
                       @"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.8.1&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453800603&page=1&argName=special&argValue=46&size=20&from=10.1.8.1&"];
    self.URLArray = @[arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8,arr9,arr10,arr11,arr12];
    
    
}

- (void)createURLWorking
{
    [OrangeBaseNetWorking orangeGetRequestWithUrl:@"http://app.u17.com/v3/app/ios/phone/sort/list?key=6c3d600b8e376499d511c646801b525d9c0828a7500facc3f3ce938f121dd2bc3aff22d8b19a5717b1954d29bb1742f72bc8415b37d81d448aca232bff0cc0128936743815eba6084f9755211318af64cbff353356ad6adbb9ced1649efbb88e5d39162b149896c26c53f0f1241b5b5346c58bdaa2e8d9c41cc029a67f8ecd27627a14dedec9ae1f:::open&version=10.1.3.4&deviceId=17fbd052360e2743d6149a6407c0b70670ac5c81&model=iPhone%206&time=1453447061&sortVersion=2&from=10.1.3.4&" successData:^(NSDictionary *fldic){
        
        
        
  
    
    NSDictionary *dic = fldic[@"data"];
    NSDictionary *dic2 = dic[@"returnData"];
    NSArray *arr = dic2[@"rankinglist"];
    
    for (NSDictionary *dic in arr) {
        fl_model *model = [[fl_model alloc] init];
        model.sortName = dic[@"sortName"];
        model.cover = dic[@"cover"];
        [self.modleArray addObject:model];
    }
        
        [_fl_collectionView reloadData];
      }];
}
///行
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}
///列
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    
    if (self.modleArray.count != 0) {
        fl_model *model = self.modleArray[indexPath.section * 3 + indexPath.row];
        cell.flmodel = model;
    }
    return  cell;
}


//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 120);
    
}
//间距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 10);
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转至下一视图
    UINavigationController *nav =(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    FL_SecondViewController *secondVC = [[FL_SecondViewController alloc] init];
            fl_model *model = self.modleArray[indexPath.section * 3 + indexPath.row];
    secondVC.title = model.sortName;
    
    secondVC.URLStr = [[self.URLArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [nav pushViewController:secondVC animated:YES];
}


@end
