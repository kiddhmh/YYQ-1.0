//
//  MenuScrollView.h
//  有妖气漫画
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuScrollView : UIScrollView
///切换按钮的数组
@property (nonatomic,strong) NSMutableArray *MenuBtnArray;
///按钮下方图片的数组
@property (nonatomic,strong) UIImageView *MenuImage;

///创建标题栏
+ (MenuScrollView *)MenuWith:(NSArray *)titleAray;

@end
