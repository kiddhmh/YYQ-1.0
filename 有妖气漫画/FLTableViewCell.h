//
//  FLTableViewCell.h
//  有妖气_分类
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FL_SecondModel;
@interface FLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fl_bookImage;
@property (weak, nonatomic) IBOutlet UILabel *fl_bookName;
@property (weak, nonatomic) IBOutlet UIImageView *fl_peopleImage;
@property (weak, nonatomic) IBOutlet UILabel *fl_peopleLable;
@property (weak, nonatomic) IBOutlet UIImageView *fl_clickImage;
@property (weak, nonatomic) IBOutlet UILabel *fl_clickLable;
@property (weak, nonatomic) IBOutlet UIImageView *fl_typeImage;
@property (weak, nonatomic) IBOutlet UILabel *fl_typeLable;
@property (weak, nonatomic) IBOutlet UILabel *fl_describeLable;

@property (strong, nonatomic) FL_SecondModel *fl_SecondModel;

@end
