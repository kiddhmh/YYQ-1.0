//
//  FLCollectionViewCell.h
//  有妖气_分类
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fl_model;
@interface FLCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fl_imageView;
@property (weak, nonatomic) IBOutlet UILabel *fl_lable;
@property (nonatomic,strong) fl_model *flmodel;

@end
