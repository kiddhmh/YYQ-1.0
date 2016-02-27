//
//  UIBarButtonItem+Extension.m
//  有妖气漫画
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Frame.h"
@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTagert:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    //设置耳目
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置按钮
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //设置尺寸
    btn.size = btn.currentImage.size;
    
    //添加按钮
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
