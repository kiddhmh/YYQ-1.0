//
//  MenuScrollView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MenuScrollView.h"
#define MyColor [UIColor colorWithRed:40/255.0 green:157/255.0 blue:32/255.0 alpha:1]

@interface MenuScrollView ()

@end

@implementation MenuScrollView

- (NSMutableArray *)MenuBtnArray
{
    if (_MenuBtnArray == nil){
        
        _MenuBtnArray = [[NSMutableArray alloc] init];
    }
    return _MenuBtnArray;
}


+ (MenuScrollView *)MenuWith:(NSArray *)titleAray
{
    NSInteger count = titleAray.count;
    MenuScrollView *menu = [[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0,375,50)];
    
    menu.backgroundColor = [UIColor whiteColor];
    
    //初始化按钮
    CGFloat btnY = 10;
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    for (int i = 0; i < count; i++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置普通文字
        [btn setTitle:titleAray[i] forState:UIControlStateNormal];
        
        //设置文字颜色
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:MyColor forState:UIControlStateHighlighted];
        [btn setTitleColor:MyColor forState:UIControlStateSelected];
        
        //设置按钮的位置
        btn.frame = CGRectMake( 40 + i*120 , btnY, btnW, btnH);
        
        btn.tag = 100 + i;
        
        [btn addTarget:menu action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = NO;
        
        if (btn.tag == 100) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
        [menu addSubview:btn];
        
        if (menu.MenuBtnArray.count != 0) {
            [menu.MenuBtnArray addObject:btn];
        }
        
    }
    
    //创建按钮下方的slider
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(40 ,btnH + btnY + 3, btnW, 5);
    imageView.backgroundColor = MyColor;
    [menu addSubview:imageView];
    
    menu.contentSize = CGSizeMake(count * 120 + 60, 0);
    menu.scrollEnabled = YES;
    menu.MenuImage = imageView;
    
    return menu;
}


#pragma mark - 按钮点击事件
- (void)btnClick:(UIButton *)btn
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeView" object:btn];
}


@end
