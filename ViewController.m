//
//  ViewController.m
//  有妖气漫画——搜索
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "ViewController.h"
#import "FirstCollectionViewCell.h"
#import "SreachView.h"
#import "OrangeBaseNetWorking.h"
#import "SearchDateModel.h"
#import "SS_ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (strong, nonatomic) SreachView *sreachView;
@property (strong, nonatomic) SearchDateModel *dataModel;

@end

static NSString *cellId = @"cellId";

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.dataModel = [[SearchDateModel alloc] init];
    
    [self sendUrlConnection];
    [self createUI];

}



#pragma mark - ----------------创建UI视图-------------------------

- (void)createUI
{
    self.sreachView = [[SreachView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.sreachView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.sreachView passBlock:^{
       
        //切换到二级视图
        SS_ViewController *SS_VC = [[SS_ViewController alloc] init];
        [self.navigationController pushViewController:SS_VC animated:YES];
    }];
    
    self.sreachView.VC_collectionView.delegate = self;
    self.sreachView.VC_collectionView.dataSource = self;
    [self.sreachView.VC_collectionView registerNib:[UINib nibWithNibName:@"FirstCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];

    
    [self.view addSubview:self.sreachView];
    
}

#pragma mark - ---------------构建网络数据------------------------------

- (void)sendUrlConnection
{
    [OrangeBaseNetWorking orangeGetRequestWithUrl:@"http://app.u17.com/v3/app/android/phone/search/hotkeywords?t=1453622721&v=2270099&android_id=14a146c2ba1ccabd&key=null&come_from=ANZHI&model=vivo+X3L"
 successData:^(NSDictionary *dic){
     

     [self.dataModel JSONModelMethod:dic];
     
     [self.sreachView.VC_collectionView reloadData];
        
    }];
    

    
}


#pragma mark - UICollectionView的协议和代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    
    [cell.btn setBackgroundColor:[UIColor colorWithRed:arc4random()%200/255.0+0.1  green:arc4random()%200/255.0+0.1 blue:arc4random()%200/255.0+0.1  alpha:0.7]];
    
    if (self.dataModel.dataMuArr.count !=0) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = self.dataModel.dataMuArr[indexPath.section*4 + indexPath.row];
        
        [cell.btn setTitle:dic[@"tag"] forState:UIControlStateNormal];
        [cell.btn setTitle:dic[@"tag"] forState:UIControlStateHighlighted];

    }
    
    

   
    
    return cell;
                                     
}

// 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(76, 30);

}

// 间距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 10);
}


@end
