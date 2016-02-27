//
//  FLTableViewCell.m
//  有妖气_分类
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "FLTableViewCell.h"
#import "FL_SecondViewController.h"
#import "FL_SecondModel.h"
#import "UIImageView+WebCache.h"
@implementation FLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFl_SecondModel:(FL_SecondModel *)fl_SecondModel
{
    
    _fl_SecondModel = fl_SecondModel;
    
    [self.fl_bookImage sd_setImageWithURL:[NSURL URLWithString:self.fl_SecondModel.fl_cover] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.fl_bookName.text = fl_SecondModel.fl_name;
    
    self.fl_clickImage.image = [UIImage imageNamed:@"00002.png"];
    
    self.fl_clickLable.text = fl_SecondModel.fl_click_total;
    
    self.fl_peopleImage.image = [UIImage imageNamed:@"00001.png"];
    
    self.fl_peopleLable.text = fl_SecondModel.fl_nickname;
    
    self.fl_typeImage.image = [UIImage imageNamed:@"00003.png"];
    
    self.fl_typeLable.text = [fl_SecondModel.fl_tags firstObject];
    
    self.fl_describeLable.text = fl_SecondModel.fl_description;
    
}
@end
