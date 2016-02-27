//
//  HMHTableViewCell.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SmallModel;
@interface HMHTableViewCell : UITableViewCell

@property (nonatomic,strong) SmallModel *smallML;

+ (HMHTableViewCell *)cellWith:(UITableView *)tableView;

@end
