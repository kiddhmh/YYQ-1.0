//
//  HMHTableViewCell.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "HMHTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SmallModel.h"
@interface HMHTableViewCell ()
///漫画图片
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

///漫画名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///漫画作者
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

///更新章节
@property (weak, nonatomic) IBOutlet UILabel *last_update_chapter_nameLabel;

///漫画描述
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end
@implementation HMHTableViewCell

+ (HMHTableViewCell *)cellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    HMHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HMHTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


///给各个子控件赋值
- (void)setSmallML:(SmallModel *)smallML
{
    //设置图片
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:smallML.cover] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //设置漫画名
    self.nameLabel.text = smallML.name;
    
    //设置作者名
    self.nicknameLabel.text = [NSString stringWithFormat:@"作者:%@",smallML.nickname];
    
    //设置描述
    self.descriptionLabel.text = smallML.des;
    
    //设置更新章节
    self.last_update_chapter_nameLabel.text = [NSString stringWithFormat:@"更新至:%@",smallML.last_update_chapter_name];
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
