//
//  DropDownMenu.m
//  登陆界面
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "DropDownMenu.h"

@implementation DropDownMenu

+ (void)showWith:(NSString *)str to:(UIView *)view belowSubView:(UIView *)belowview
{
    
    CGFloat labelX = 0;
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width;
    CGFloat labelH = 35;
    CGFloat labelY = 64 - labelH;
    
    DropDownMenu *menu = [[DropDownMenu alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelW, labelH)];
    label.text = str;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    
    [menu addSubview:label];
    
    [view insertSubview:menu belowSubview:belowview];
    
    //设置动画
    [UIView animateWithDuration:0.8 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0,labelH);
        
    } completion:^(BOOL finished) {
        
        //延时0.8秒
        [UIView animateWithDuration:0.8 delay:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [menu removeFromSuperview];
        }];
    }];
}

@end
