//
//  FirstTableViewCell.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

//漫画封面图片
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
//漫画名称Label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//作者名称Label
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
//总点击Label
@property (weak, nonatomic) IBOutlet UILabel *extraValueLabel;
//最新更新章节Label
@property (weak, nonatomic) IBOutlet UILabel *last_update_chapter_nameLabel;
//漫画类型Label
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;




//独家图片
@property (weak, nonatomic) IBOutlet UIImageView *is_dujiaimageView;















@end
