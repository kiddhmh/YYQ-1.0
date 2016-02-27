//
//  RankingListTableViewCell.h
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingListTableViewCell : UITableViewCell
/**
 *  主题
 */
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* lineLabel;
@property (strong, nonatomic) UILabel* rankingDescription1Label;
@property (strong, nonatomic) UILabel* rankingDescription2Label;
@property (strong, nonatomic) UIImageView* imageView;
/**
 *  背景视图
 */
@property (strong, nonatomic) UIView* viewBachground;


@end
