//
//  FLCollectionViewCell.m
//  有妖气_分类
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "FLCollectionViewCell.h"
#import "fl_model.h"
#import "UIImageView+WebCache.h"
@implementation FLCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFlmodel:(fl_model *)flmodel
{
    
    _flmodel = flmodel;
    
    [self.fl_imageView sd_setImageWithURL:[NSURL URLWithString:flmodel.cover] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.fl_lable.text = flmodel.sortName;
}

@end
