//
//  ClassifyViewController.h
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrangeBaseNetWork;

@class RankingListJsonModel;
@class RankingListTableViewCell;


@interface RankingListViewController : UIViewController
{
    //解析模型
    RankingListJsonModel *jsonModel;
    //自定义Cell
    RankingListTableViewCell *rankingListCell;
    
}
@property (assign, nonatomic) NSInteger number;

@end
