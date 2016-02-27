//
//  HeadView.h
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView<UIActionSheetDelegate>
/// 返回按钮
@property (strong, nonatomic) UIButton *backBtn;
/// 标题标签
@property (strong, nonatomic) UILabel *titleLabel;
/// 进度条
@property (strong, nonatomic) UISlider *slider;
/// 索引按钮
@property (strong, nonatomic) UIButton *indexBtn;
/// UIActionSheet
@property (strong, nonatomic) UIActionSheet *sheet;
/// 索引标签
@property (strong, nonatomic) UILabel *indexLabel;



@end
